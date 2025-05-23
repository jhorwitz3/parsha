/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// The Cloud Functions for Firebase SDK to set up triggers and logging.

import {onRequest} from "firebase-functions/https";
import {getFirestore} from "firebase-admin/firestore";
import {defineSecret} from "firebase-functions/params";
import {initializeApp, getApps} from "firebase-admin/app";
import {genParsha} from "./flow.js";
import {ScheduledEvent, onSchedule} from "firebase-functions/scheduler";
import {logger} from "firebase-functions";
import ParshaInfo, {getCurrentParsha} from "./hebcal.js";
import {generateImageUrlAndSaveToFirestore, ImageGenerationResult} from "./image.js";
import {Parsha} from "./db.js";
import {setTimeout} from "timers/promises";
import {ParshaWithImages, StringImagePair} from "./schema.js";

if (!getApps().length) initializeApp();
const db = getFirestore();
const apiKey = defineSecret("GOOGLE_GENAI_API_KEY");

const genParshaSummary = async (apiKey: any):Promise<Parsha> => {
  // get currentParsha name, generate description
  const parshaInfo: ParshaInfo = getCurrentParsha(false);
  const data: Parsha = await genParsha(apiKey.value(), parshaInfo.parsha);

  // Push the new message into Firestore using the Firebase Admin SDK.
  await db
    .collection("currentParsha").doc("today")
    .set(data);
  // Send back a message that we've successfully written the message
  logger.log(`Parashat: ${data.name} added now.`);

  return data;
};

// generate an image from prompt, save to images folder, wait for timeout, return url
const genImage = async (prompt: string):Promise<string | undefined> => {
  // generate an image for summary
  const imageResult:ImageGenerationResult = await generateImageUrlAndSaveToFirestore(prompt, "images");
  await setTimeout(65000); // sleep for 65 seconds to avoid quota of 1 query per minute
  return imageResult.imageUrl;
};

const assembleParshaWithImages = async (parsha:Parsha):Promise<ParshaWithImages> => {
  // for each piece of the parsha, generate an image and store the URL-string pair in the parshawithimages object

  const parshaWithImages: ParshaWithImages = {
    name: parsha.name,
    summary: {string: parsha.summary, url: ""},
    keyPoints: [],
    themes: [],
    characters: parsha.characters,
    lessons: [],
  };

  // summary
  const summaryPrompt = `Generate an image that illustrates the story of ${parsha.name}`;
  const summaryUrl = await genImage(summaryPrompt);
  const summaryUrlPair:StringImagePair = {string: parsha.summary, url: summaryUrl??""};
  parshaWithImages.summary = summaryUrlPair;

  // Push the new message into Firestore using the Firebase Admin SDK after each update
  await db
    .collection("currentParshaWithImages").doc("today")
    .set(parshaWithImages);

  // themes
  // generate an image for each theme
  for (const theme of parsha.themes) {
    const prompt = `Generate an image that illustrates the theme of ${theme} in ${parsha.name}`;
    const themeUrl: string = await genImage(prompt) ?? "fail";
    parshaWithImages.themes.push({string: theme, url: themeUrl});
  }

  // Push the new message into Firestore using the Firebase Admin SDK after each update
  await db
    .collection("currentParshaWithImages").doc("today")
    .set(parshaWithImages);

  // keyPoints
  // generate an image for each keyPoint
  for (const point of parsha.keyPoints) {
    const prompt = `Generate an image that illustrates ${point} as described in ${parsha.name}`;
    const pointUrl: string = await genImage(prompt) ?? "fail";
    parshaWithImages.keyPoints.push({string: point, url: pointUrl});
  }

  // Push the new message into Firestore using the Firebase Admin SDK after each update
  await db
    .collection("currentParshaWithImages").doc("today")
    .set(parshaWithImages);

  // lessons
  // generate an image for each lesson
  for (const lesson of parsha.lessons) {
    const prompt = `Generate an image that illustrates ${lesson} as described in ${parsha.name}`;
    const lessonUrl: string = await genImage(prompt) ?? "fail";
    parshaWithImages.lessons.push({string: lesson, url: lessonUrl});
  }

  // Push the new message into Firestore using the Firebase Admin SDK after each update
  await db
    .collection("currentParshaWithImages").doc("today")
    .set(parshaWithImages);

  return parshaWithImages;
};


const genParshaWithImages = async (apiKey: any):Promise<ParshaWithImages> => {
  // get currentParsha name, generate description
  const parshaInfo: ParshaInfo = getCurrentParsha(false);
  const data: Parsha = await genParsha(apiKey.value(), parshaInfo.parsha);

  const parshaWithImages:ParshaWithImages = await assembleParshaWithImages(data);

  // Send back a message that we've successfully written the message
  logger.log(`Parashat: ${data.name} added with images.`);

  return parshaWithImages;
};

exports.today = onRequest({secrets: [apiKey], memory: "1GiB"}, async (req, res) => {
  const parsha:Parsha = await genParshaSummary(apiKey);
  // Send back a message that we've successfully written the message
  res.json({result: `Parashat: ${parsha.name} added to db`});
});

exports.daily = onSchedule({schedule: "every day 00:00",
  secrets: [apiKey], memory: "1GiB"},
async (event:ScheduledEvent) => {
  await genParshaSummary(apiKey);
});

// 20 minutes timeout (!!)
exports.genImageUrl = onRequest({secrets: [apiKey], timeoutSeconds: 1200, memory: "1GiB"}, async (req, res) => {
  const parshaWithImages:ParshaWithImages = await genParshaWithImages(apiKey);
  res.json({result: `ParshaWithImages added for ${parshaWithImages.name}`});
});

// 20 minutes timeout (!!)
exports.dailyImages = onSchedule({schedule: "every day 00:10",
  secrets: [apiKey], memory: "1GiB", timeoutSeconds: 1200},
async (event:ScheduledEvent) => {
  const parshaWithImages:ParshaWithImages = await genParshaWithImages(apiKey);
  logger.log(`ParshaWithImages added for ${parshaWithImages.name}`);
});
