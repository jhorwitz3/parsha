import {genkit} from "genkit";
import {gemini20Flash, googleAI} from "@genkit-ai/googleai";
import {z} from "zod";

// Updated schema with structured content sections using bullet points
const ParshaSchema = z.object({
  name: z.string(),
  summary: z.string(), // Brief summary of the parsha
  keyPoints: z.array(z.string()), // Main bullet points of the story
});

export const genParsha = async (apiKey: string, parshaName: string) => {
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
        prompt: `For the Torah parsha named "${parshaName}", please 
        provide the following information in a structured format:

1. The exact name of this parsha
Do not include the word 'parashat' in the name
2. A brief summary (2-3 sentences) of what this parsha is about
3. 5-7 bullet points describing the key events in the parsha 
- each point should be a single sentence
- each point should describe a visual scene

Format all bullet points as simple, clear statements that would 
display well in a mobile app.
Each bullet point should be concise (preferably under 15 words) 
and focused on one idea.`,
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
