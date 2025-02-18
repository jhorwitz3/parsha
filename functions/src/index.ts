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
// import {defineSecret} from "firebase-functions/params";
// import {getFirestore} from "firebase-admin/firestore";
// import {parshaDescriptionFlow} from "./flow";
import {getFirestore} from "firebase-admin/firestore";
import {defineSecret} from "firebase-functions/params";
import {initializeApp} from "firebase-admin/app";
import {z} from "zod";
import {genkit} from "genkit";
import {gemini20Flash, googleAI} from "@genkit-ai/googleai";


// import {genkit} from "genkit";
// import {onInit} from "firebase-functions";
// import {gemini20Flash, googleAI} from "@genkit-ai/googleai";


// import {ScheduledEvent, onSchedule} from "firebase-functions/v2/scheduler";
// import {logger} from "firebase-functions";

initializeApp();
const db = getFirestore();
const apiKey = defineSecret("GOOGLE_GENAI_API_KEY");

const ParshaSchema = z.object({
  name: z.string(),
  description: z.string(),
  characters: z.array(z.string()),
});


// Take the text parameter passed to this HTTP endpoint and insert it into
// Firestore under the path /messages/:documentId/original
exports.addTodayParsha = onRequest({secrets: [apiKey]}, async (req, res) => {
  // configure a Genkit instance
  const ai = genkit({
    plugins: [googleAI({apiKey: apiKey.value()})],
    model: gemini20Flash, // set default model
  });

  const parshaDescriptionFlow = ai.defineFlow(
    {
      name: "parshaDescriptionFlow",
      outputSchema: ParshaSchema,

    },
    async () => {
      const {output} = await ai.generate({
        model: gemini20Flash,
        prompt: `Give the name of this weeks parsha, 
      a description of the story of the parsha, 
      and identify all key characters, providing brief bios of each character.`,
        output: {schema: ParshaSchema},
      });
      if (output == null) {
        throw new Error("Response doesn't satisfy schema.");
      }
      return output;
    }
  );

  const parshaOut = await parshaDescriptionFlow();


  const data = {
    name: parshaOut.name,
    description: parshaOut.description,
    characters: parshaOut.characters,
  };

  // Push the new message into Firestore using the Firebase Admin SDK.
  await db
    .collection("currentParsha").doc("today")
    .set(data);
  // Send back a message that we've successfully written the message
  res.json({result: `Parashat: ${data.name} added now.`});
});

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


