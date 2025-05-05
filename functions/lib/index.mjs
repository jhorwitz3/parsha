"use strict";
/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */
Object.defineProperty(exports, "__esModule", { value: true });
// The Cloud Functions for Firebase SDK to set up triggers and logging.
const https_1 = require("firebase-functions/https");
const firestore_1 = require("firebase-admin/firestore");
const params_1 = require("firebase-functions/params");
const app_1 = require("firebase-admin/app");
const flow_js_1 = require("./flow.js");
const scheduler_1 = require("firebase-functions/scheduler");
const firebase_functions_1 = require("firebase-functions");
const hebcal_mjs_1 = require("./hebcal.mjs");
(0, app_1.initializeApp)();
const db = (0, firestore_1.getFirestore)();
const apiKey = (0, params_1.defineSecret)("GOOGLE_GENAI_API_KEY");
// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /messages/:documentId/original
exports.addTodayParsha = (0, https_1.onRequest)({ secrets: [apiKey] }, async (req, res) => {
    // get currentParsha name, generate description
    const parshaInfo = (0, hebcal_mjs_1.getCurrentParsha)(false);
    const parshaOut = await (0, flow_js_1.genParsha)(apiKey.value(), parshaInfo.parsha);
    const data = {
        name: parshaOut.name,
        summary: parshaOut.summary,
        keyPoints: parshaOut.keyPoints,
        themes: parshaOut.themes,
        characters: parshaOut.characters,
        lessons: parshaOut.lessons
    };
    firebase_functions_1.logger.log(`Parashat: ${data.name} added now for HebCal ${parshaInfo.parsha}.`);
    firebase_functions_1.logger.log(`date: ${parshaInfo.date}`);
    // Push the new message into Firestore using the Firebase Admin SDK.
    await db
        .collection("currentParsha").doc("today")
        .set(data);
    // Send back a message that we've successfully written the message
    res.json({ result: `Parashat: ${data.name} added now for HebCal ${parshaInfo.parsha}.` });
});
exports.genParshaDaily = (0, scheduler_1.onSchedule)({ schedule: "every day 00:00",
    secrets: [apiKey] }, async (event) => {
    // get currentParsha name, generate description
    const parshaInfo = (0, hebcal_mjs_1.getCurrentParsha)(false);
    const parshaOut = await (0, flow_js_1.genParsha)(apiKey.value(), parshaInfo.parsha);
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
    firebase_functions_1.logger.log(`event: ${event.jobName} at ${event.scheduleTime}.`);
    firebase_functions_1.logger.log(`Parashat: ${data.name} added now.`);
});
//# sourceMappingURL=index.mjs.map