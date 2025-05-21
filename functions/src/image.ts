// For Firebase Functions, install these packages:
// npm install firebase-admin @google-cloud/aiplatform
// npm install -D typescript @types/node

import * as admin from "firebase-admin";
import {PredictionServiceClient, helpers} from "@google-cloud/aiplatform";

// Define interfaces for strongly typed parameters
interface ImageGenerationParams {
  width: number;
  height: number;
}

interface AdditionalImageData {
  userId?: string;
  negativePrompt?: string;
  imageSize?: ImageGenerationParams;
  gcsUri?: string;
  // Using a more specific index signature
  [key: string]: string | number | boolean | object | undefined;
}

interface ImageGenerationResult {
  success: boolean;
  documentId: string;
  imageUrl?: string;
  prompt: string;
  storagePath?: string;
}

interface StorageResult {
  filePath: string;
  publicUrl: string;
}

// Initialize Firebase Admin SDK
if (!admin.apps.length) {
  admin.initializeApp();
}

// Access Firestore through Firebase Admin
const firestore = admin.firestore();

// Configure the AI Platform client
const location = process.env.GCP_LOCATION || "us-central1";
const projectId = process.env.GCP_PROJECT_ID ||
  (admin.instanceId().app.options.projectId as string);

// Specifies the location of the api endpoint
const clientOptions = {
  apiEndpoint: `${location}-aiplatform.googleapis.com`,
};

// Instantiates the Prediction Service client
const predictionServiceClient = new PredictionServiceClient(clientOptions);

/**
 * Generates an image using Google Vertex AI Imagen
 *
 * @param {string} prompt - The text prompt for image generation
 * @param {AdditionalImageData} additionalData - Any additional data to store with the image
 * @return {Promise<ImageGenerationResult>} The Firestore document reference and generation details
 */
async function generateImage(
  prompt: string,
  additionalData: AdditionalImageData = {}
): Promise<protobuf.common.IValue> {
  try {
    console.log(`Generating image for prompt: "${prompt}"`);

    // Configure the endpoint
    const endpoint =
      `projects/${projectId}/locations/${location}/publishers/google/models/imagen-3.0-generate-001`;

    // Create prompt instance
    const promptText = {prompt};
    const instanceValue = helpers.toValue(promptText);
    const instances = [instanceValue] as protobuf.common.IValue[];

    // Set parameters for image generation
    const parameter = {
      sampleCount: 1,
      aspectRatio: additionalData.imageSize ?
        `${additionalData.imageSize.width}:${additionalData.imageSize.height}` :
        "1:1",
      safetyFilterLevel: "block_some",
      personGeneration: "allow_adult",
    };

    const parameters = helpers.toValue(parameter);

    // Create request
    const request = {
      endpoint,
      instances,
      parameters,
    };

    // Make prediction request
    const [response] = await predictionServiceClient.predict(request);
    const predictions = response.predictions;

    // Check if we have a valid response
    if (!predictions || predictions.length === 0) {
      throw new Error("No image was generated");
    }

    // Get the base64 image data from the first prediction
    const prediction = predictions[0];

    return prediction as protobuf.common.IValue;
  } catch (error) {
    console.error("Error generating or saving image:", error);
    throw error;
  }
}

/**
 * Generates an image using Google Vertex AI Imagen and saves it to Firestore
 *
 * @param {string} prompt - The text prompt for image generation
 * @param {string} collectionName - Firestore collection to save the image data
 * @param {AdditionalImageData} additionalData - Any additional data to store with the image
 * @return {Promise<ImageGenerationResult>} The Firestore document reference and generation details
 */
async function generateImageAndSaveToFirestore(
  prompt: string,
  collectionName: string,
  additionalData: AdditionalImageData = {}
): Promise<ImageGenerationResult> {
  try {
    const prediction = await generateImage(prompt, additionalData);
    const imageData = prediction.structValue!.fields!.bytesBase64Encoded.stringValue;

    // Create a document in Firestore
    const docData = {
      prompt,
      imageData,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      ...additionalData,
    };

    // Save to Firestore
    const collectionRef = firestore.collection(collectionName);
    const docRef = await collectionRef.add(docData);

    console.log(`Image successfully saved to Firestore with ID: ${docRef.id}`);

    return {
      success: true,
      documentId: docRef.id,
      prompt,
    };
  } catch (error) {
    console.error("Error generating or saving image:", error);
    throw error;
  }
}

/**
 * Alternative function to save image URL instead of base64 data
 * Use this if your Vertex AI setup returns URLs or if you want to save
 * the image to Cloud Storage first
 *
 * @param {string} prompt - The text prompt for image generation
 * @param {string} collectionName - Firestore collection to save the image data
 * @param {AdditionalImageData} additionalData - Any additional data to store
 * @return {Promise<ImageGenerationResult>} The result of the image generation
 */
async function generateImageUrlAndSaveToFirestore(
  prompt: string,
  collectionName: string,
  additionalData: AdditionalImageData = {}
): Promise<ImageGenerationResult> {
  try {
    // Generate the image and get base64 data
    const prediction = await generateImage(prompt, additionalData);
    const imageData = prediction.structValue!.fields!.bytesBase64Encoded.stringValue;

    if (imageData == null) {
      console.error("null image");
    }

    // Generate a unique filename
    const fileName =
      `img_${Date.now()}_${Math.random().toString(36).substring(2, 15)}`;

    // Create folder path
    const userId = additionalData.userId || "anonymous";
    const folderPath = `generated-images/${userId}`;

    // Save to Storage and get the URL
    const {filePath, publicUrl} = await saveImageToStorage(
      imageData!,
      folderPath,
      fileName
    );

    // Save URL to Firestore instead of base64 data
    const docData = {
      prompt,
      imageUrl: publicUrl,
      storagePath: filePath,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      ...additionalData,
    };

    // Save to Firestore
    const collectionRef = firestore.collection(collectionName);
    const docRef = await collectionRef.add(docData);

    console.log(`Image URL successfully saved to Firestore with ID: ${docRef.id}`);

    return {
      success: true,
      documentId: docRef.id,
      prompt,
      imageUrl: publicUrl,
    };
  } catch (error) {
    console.error("Error generating or saving image URL:", error);
    throw error;
  }
}

/**
 * Utility function to save generated image to Cloud Storage
 * More appropriate for large images than storing in Firestore
 *
 * @param {string} imageBase64 - Base64-encoded image data
 * @param {string} folderPath - Storage folder path
 * @param {string} fileName - Name of the file to save
 * @return {Promise<StorageResult>} Storage path and public URL
 */
async function saveImageToStorage(
  imageBase64: string,
  folderPath: string,
  fileName: string
): Promise<StorageResult> {
  // Get default bucket or specify one
  const bucket = admin.storage().bucket();

  // Create a buffer from base64 data
  const imageBuffer = Buffer.from(imageBase64, "base64");

  // Create the file path
  const filePath = `${folderPath}/${fileName}.png`;
  const file = bucket.file(filePath);

  // Save the image to Cloud Storage
  await file.save(imageBuffer, {
    metadata: {
      contentType: "image/png",
    },
  });

  // Make the file publicly accessible (optional)
  await file.makePublic();

  // Get the public URL
  const publicUrl = `https://storage.googleapis.com/${bucket.name}/${filePath}`;

  return {filePath, publicUrl};
}

/**
 * Enhanced function that stores image data in Firebase Storage instead of Firestore
 * and only saves the reference URL in Firestore
 *
 * @param {string} prompt - The text prompt for image generation
 * @param {string} collectionName - Firestore collection to save the reference
 * @param {AdditionalImageData} additionalData - Any additional data to store
 * @return {Promise<ImageGenerationResult>} The result of the image generation
 */
async function generateImageAndSaveToStorage(
  prompt: string,
  collectionName: string,
  additionalData: AdditionalImageData = {}
): Promise<ImageGenerationResult> {
  try {
    // Configure the endpoint
    const endpoint =
      `projects/${projectId}/locations/${location}/publishers/google/models/imagen-3.0-generate-001`;

    // Create prompt instance
    const promptText = {prompt};
    const instanceValue = helpers.toValue(promptText);
    const instances = [instanceValue] as protobuf.common.IValue[];

    // Set parameters for image generation
    const parameter = {
      sampleCount: 1,
      aspectRatio: additionalData.imageSize ?
        `${additionalData.imageSize.width}:${additionalData.imageSize.height}` :
        "1:1",
      safetyFilterLevel: "block_some",
      personGeneration: "allow_adult",
    };

    const parameters = helpers.toValue(parameter);

    // Create request
    const request = {
      endpoint,
      instances,
      parameters,
    };

    // Make prediction request
    const predictResponse = await predictionServiceClient.predict(request);
    const response = predictResponse[0];
    const predictions = response.predictions;

    // Check if we have a valid response
    if (!predictions || predictions.length === 0) {
      throw new Error("No image was generated");
    }

    // Get the base64 image data from the first prediction
    const prediction = predictions[0];
    const imageBase64 = prediction.structValue!.fields!.bytesBase64Encoded.stringValue;

    // Generate a unique filename
    const fileName =
      `img_${Date.now()}_${Math.random().toString(36).substring(2, 15)}`;

    // Create folder path (optional: organize by user/date)
    const userId = additionalData.userId || "anonymous";
    const folderPath = `generated-images/${userId}`;

    // Save the image to Firebase Storage
    const {filePath, publicUrl} = await saveImageToStorage(
      imageBase64!,
      folderPath,
      fileName
    );

    // Create a document in Firestore with just the image reference
    const docData = {
      prompt,
      imageUrl: publicUrl,
      storagePath: filePath,
      createdAt: admin.firestore.FieldValue.serverTimestamp(),
      ...additionalData,
    };

    // Save to Firestore
    const collectionRef = firestore.collection(collectionName);
    const docRef = await collectionRef.add(docData);

    console.log(
      `Image reference successfully saved to Firestore with ID: ${docRef.id}`
    );

    return {
      success: true,
      documentId: docRef.id,
      imageUrl: publicUrl,
      storagePath: filePath,
      prompt,
    };
  } catch (error) {
    console.error("Error generating or saving image:", error);
    throw error;
  }
}

// Export the functions
export {
  generateImageAndSaveToFirestore,
  generateImageUrlAndSaveToFirestore,
  generateImageAndSaveToStorage,
  ImageGenerationResult,
};
