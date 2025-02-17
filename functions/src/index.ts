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
// import {getFirestore} from "firebase-admin/firestore";
import {parshaDescriptionFlow} from "./flow";
import admin from "firebase-admin";

const googleAIapiKey = defineSecret("GOOGLE_GENAI_API_KEY");
// import {ScheduledEvent, onSchedule} from "firebase-functions/v2/scheduler";
// import {logger} from "firebase-functions";

// The Firebase Admin SDK to delete inactive users.
admin.initializeApp();

// Run once a day at midnight, to clean up the users
// Manually run the task here https://console.cloud.google.com/cloudscheduler
export const generateParsha = onCallGenkit(
  {secrets: [googleAIapiKey]},
  parshaDescriptionFlow);

// exports.getparsha = onSchedule("every day 00:00",
//   async (event:ScheduledEvent) => {
//   // Fetch all user details.
//     const schema = await parshaDescriptionFlow();

//     // logger.log("schema");
//     // logger.log("name: %s", schema.name);
//     // logger.log("description: %s", schema.description);
//     // logger.log("characters: %s", schema.characters);
//     logger.log(`schema: ${schema}`);

//     const writeResult = await getFirestore()
//       .collection("currentParsha")
//       .add({newParsha: schema});

//     logger.log(`writeresult: ${writeResult}`);
//   });


