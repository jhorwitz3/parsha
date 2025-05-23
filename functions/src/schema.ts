import {z} from "zod";

const StringImagePairSchema = z.object({
  string: z.string(),
  url: z.string(),
});

// Parsha Schema definition
const CharacterSchema = z.object({
  name: z.string(),
  description: z.string(),
  keyActions: z.array(z.string()), // Bullet points of character actions
});

const ParshaSchema = z.object({
  name: z.string(),
  summary: z.string(), // Brief summary of the parsha
  keyPoints: z.array(z.string()), // Main bullet points of the story
  themes: z.array(z.string()), // Bullet points of main themes
  characters: z.array(CharacterSchema),
  lessons: z.array(z.string()), // Bullet points of lessons/messages
});

const ParshaWithImageSchema = z.object({
  name: z.string(),
  summary: StringImagePairSchema, // Brief summary of the parsha
  keyPoints: z.array(StringImagePairSchema), // Main bullet points of the story
  themes: z.array(StringImagePairSchema), // Bullet points of main themes
  characters: z.array(CharacterSchema),
  lessons: z.array(StringImagePairSchema), // Bullet points of lessons/messages
});

// Type inference from the schema
// type Character = z.infer<typeof CharacterSchema>;
type Parsha = z.infer<typeof ParshaSchema>;
type ParshaWithImages = z.infer<typeof ParshaWithImageSchema>;
type StringImagePair = z.infer<typeof StringImagePairSchema>;

export {Parsha, ParshaWithImages, StringImagePair, ParshaSchema, CharacterSchema};
