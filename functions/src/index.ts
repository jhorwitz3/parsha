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
import {Parsha, getTodaysParsha} from "./db.js";
import {setTimeout} from "timers/promises";

if (!getApps().length) initializeApp();
const db = getFirestore();
const apiKey = defineSecret("GOOGLE_GENAI_API_KEY");


// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /messages/:documentId/original
exports.today = onRequest({secrets: [apiKey], memory: "1GiB"}, async (req, res) => {
  // get currentParsha name, generate description
  const parshaInfo: ParshaInfo = getCurrentParsha(false);
  const parshaOut = await genParsha(apiKey.value(), parshaInfo.parsha);

  const data = {
    name: parshaOut.name,
    summary: parshaOut.summary,
    keyPoints: parshaOut.keyPoints,
    themes: parshaOut.themes,
    characters: parshaOut.characters,
    lessons: parshaOut.lessons,
  };

  logger.log(`Parashat: ${data.name} added now 
  for HebCal ${parshaInfo.parsha}.`);
  logger.log(`date: ${parshaInfo.date}`);

  // Push the new message into Firestore using the Firebase Admin SDK.
  await db
    .collection("currentParsha").doc("today")
    .set(data);
  // Send back a message that we've successfully written the message
  res.json({result: `Parashat: ${data.name} added now 
  for HebCal ${parshaInfo.parsha}.`});
});

exports.daily = onSchedule({schedule: "every day 00:00",
  secrets: [apiKey], memory: "1GiB"},
async (event:ScheduledEvent) => {
  // get currentParsha name, generate description
  const parshaInfo: ParshaInfo = getCurrentParsha(false);
  const parshaOut = await genParsha(apiKey.value(), parshaInfo.parsha);

  const data = {
    name: parshaOut.name,
    summary: parshaOut.summary,
    keyPoints: parshaOut.keyPoints,
    themes: parshaOut.themes,
    characters: parshaOut.characters,
    lessons: parshaOut.lessons,
  };

  // Push the new message into Firestore using the Firebase Admin SDK.
  await db
    .collection("currentParsha").doc("today")
    .set(data);
  // Send back a message that we've successfully written the message
  logger.log(`event: ${event.jobName} at ${event.scheduleTime}.`);
  logger.log(`Parashat: ${data.name} added now.`);
});

exports.genImageUrl = onRequest({secrets: [apiKey], timeoutSeconds: 500, memory: "1GiB"}, async (req, res) => {
  const parsha:Parsha|null = await getTodaysParsha();
  if (!parsha) {
    console.error("Failed to get valid parsha data");
    return;
  }

  const results:string[] = [];

  for (const theme of parsha.themes) {
    const prompt = `Generate an image that illustrates the theme of ${theme} in ${parsha.name}`;
    const imageResult:ImageGenerationResult = await generateImageUrlAndSaveToFirestore(prompt, "themes", theme);
    results.push(imageResult.imageUrl ?? "fail");
    await setTimeout(65000); // sleep for 65 seconds to avoid quota of 1 query per minute
  }
  res.json({result: `Images added with results: ${results} `});
});
