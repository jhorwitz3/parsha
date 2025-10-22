import {z} from "zod";

const StringImagePairSchema = z.object({
  string: z.string(),
  url: z.string(),
});

const ParshaSchema = z.object({
  name: z.string(),
  summary: z.string(), // Brief summary of the parsha
  keyPoints: z.array(z.string()), // Main bullet points of the story
});

const ParshaWithImageSchema = z.object({
  name: z.string(),
  summary: StringImagePairSchema, // Brief summary of the parsha
  keyPoints: z.array(StringImagePairSchema), // Main bullet points of the story
});

// Type inference from the schema
// type Character = z.infer<typeof CharacterSchema>;
type Parsha = z.infer<typeof ParshaSchema>;
type ParshaWithImages = z.infer<typeof ParshaWithImageSchema>;
type StringImagePair = z.infer<typeof StringImagePairSchema>;

export {Parsha, ParshaWithImages, StringImagePair, ParshaSchema};
