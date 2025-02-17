// import the Genkit and Google AI plugin libraries
import { gemini20Flash, googleAI } from '@genkit-ai/googleai';
import { genkit } from 'genkit';
import { z } from "zod";
import { onCallGenkit } from 'firebase-functions/https';
import {defineSecret} from "firebase-functions/params";

const googleAIapiKey = defineSecret("GOOGLE_GENAI_API_KEY");

// configure a Genkit instance
const ai = genkit({
  plugins: [googleAI()],
  model: gemini20Flash, // set default model
});

const ParshaSchema = z.object({
    name: z.string(),
    description: z.string(),
    characters: z.array(z.string())
  });
  
  export const parshaDescriptionFlow = ai.defineFlow(
    {
      name: 'parshaDescriptionFlow',
      outputSchema: ParshaSchema,
    },
    async () => {
      const { output } = await ai.generate({
        model: gemini20Flash,
        prompt: `Give the name of this weeks parsha, a description of the story of the parsha, and identify all key characters, providing brief bios of each character `,
        output: { schema: ParshaSchema },
      });
      if (output == null) {
        throw new Error("Response doesn't satisfy schema.");
      }
      return output;
    }
  );

export const generateParsha = onCallGenkit(
    {secrets: [googleAIapiKey]},
    parshaDescriptionFlow);


// async function main() {
//   // make a generation request
//   const { name, description, characters }  =
//   await menuSuggestionFlowWithSchema();
//   console.log('name is %s', name);
//   console.log('description is %s', description);
//   for (var character in characters){
//     console.log('character: %s', character);

//   }
// }

// main();