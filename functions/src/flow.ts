
import {genkit} from "genkit";
import {gemini20Flash, googleAI} from "@genkit-ai/googleai";
import {z} from "zod";


const ParshaSchema = z.object({
  name: z.string(),
  description: z.string(),
  characters: z.array(z.string()),
});

export const genParsha = async (apiKey: string) =>{
  // configure a Genkit instance
  const ai = genkit({
    plugins: [googleAI({apiKey: apiKey})],
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
  return parshaOut;
};
