// Import Firebase modules
import {initializeApp, getApps, getApp} from "firebase-admin/app";
import {getFirestore} from "firebase-admin/firestore";
import {Parsha, ParshaSchema} from "./schema";


// Initialize Firebase
let app;
if (!getApps().length) {
  app = initializeApp();
} else {
  app = getApp();
}

const db = getFirestore(app);

/**
 * Fetches today's parsha from Firestore
 * @return {Promise<Parsha|null>} The parsha data or null if not found
 */
async function getTodaysParsha(): Promise<Parsha | null> {
  try {
    // Reference to the "today" document in the "currentParsha" collection
    const parshaSnap = await db.collection("currentParsha").doc("today").get();


    // Check if document exists
    if (parshaSnap.exists) {
      const rawData = parshaSnap.data();

      // Validate against schema
      try {
        const parshaData = ParshaSchema.parse(rawData);
        console.log("Today's parsha data:", parshaData);
        return parshaData;
      } catch (validationError) {
        console.error("Parsha data validation failed:", validationError);
        return null;
      }
    } else {
      console.log("No parsha document found for today!");
      return null;
    }
  } catch (error) {
    console.error("Error fetching today's parsha:", error);
    throw error;
  }
}

export {getTodaysParsha, Parsha};
