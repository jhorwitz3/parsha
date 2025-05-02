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
import {initializeApp} from "firebase-admin/app";
import {genParsha} from "./flow.js";
import {ScheduledEvent, onSchedule} from "firebase-functions/scheduler";
import {logger} from "firebase-functions";
import {getCurrentParsha, ParshaInfo} from "./hebcal.mjs";


initializeApp();
const db = getFirestore();
const apiKey = defineSecret("GOOGLE_GENAI_API_KEY");


// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /messages/:documentId/original
exports.addTodayParsha = onRequest({secrets: [apiKey]}, async (req, res) => {
  // get currentParsha name, generate description
  const parshaInfo: ParshaInfo = getCurrentParsha(false);
  const parshaOut = await genParsha(apiKey.value(), parshaInfo.parsha);

  const data = {
    name: parshaOut.name,
    summary: parshaOut.summary,
    keyPoints: parshaOut.keyPoints,
    themes: parshaOut.themes,
    characters: parshaOut.characters,
    lessons: parshaOut.lessons
};

  logger.log(`Parashat: ${data.name} added now for HebCal ${parshaInfo.parsha}.`);
  logger.log(`date: ${parshaInfo.date}`);

  // Push the new message into Firestore using the Firebase Admin SDK.
  await db
    .collection("currentParsha").doc("today")
    .set(data);
  // Send back a message that we've successfully written the message
  res.json({result: `Parashat: ${data.name} added now for HebCal ${parshaInfo.parsha}.`});
});

exports.genParshaDaily = onSchedule({schedule: "every day 00:00",
  secrets: [apiKey]},
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
    lessons: parshaOut.lessons
};

  // Push the new message into Firestore using the Firebase Admin SDK.
  await db
    .collection("currentParsha").doc("today")
    .set(data);
  // Send back a message that we've successfully written the message
  logger.log(`event: ${event.jobName} at ${event.scheduleTime}.`);
  logger.log(`Parashat: ${data.name} added now.`);
});


