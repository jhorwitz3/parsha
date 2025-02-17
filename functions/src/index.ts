/**
 * Import function triggers from their respective submodules:
 *
 * import {onCall} from "firebase-functions/v2/https";
 * import {onDocumentWritten} from "firebase-functions/v2/firestore";
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

// The Cloud Functions for Firebase SDK to set up triggers and logging.

import {onCallGenkit} from "firebase-functions/https";
import {defineSecret} from "firebase-functions/params";
import {parshaDescriptionFlow} from "./flow";
import admin from "firebase-admin";

const googleAIapiKey = defineSecret("GOOGLE_GENAI_API_KEY");
// const {onSchedule} = require("firebase-functions/v2/scheduler");
// const {logger} = require("firebase-functions");

// The Firebase Admin SDK to delete inactive users.
admin.initializeApp();

// Run once a day at midnight, to clean up the users
// Manually run the task here https://console.cloud.google.com/cloudscheduler
// exports.getparsha = onSchedule("every day 00:00", async (event:any) => {
//     // Fetch all user details.
//     const schema = await parshaDescriptionFlow();

//     logger.log("schema");
//     logger.log("name: %s", schema.name);
//     logger.log("description: %s", schema.description);
//     logger.log("characters: %s", schema.characters);
//     logger.log("event: %s", event);
//   });

export const generateParsha = onCallGenkit(
{secrets: [googleAIapiKey]},
parshaDescriptionFlow);