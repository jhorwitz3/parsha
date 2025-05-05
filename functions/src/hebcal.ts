import {HDate, Sedra} from "@hebcal/core";

/**
 * Interface for parsha information response
 */
interface ParshaInfo {
  date: string;
  hebrewDate: string;
  parsha: string
}

export default ParshaInfo;

/**
 * Gets the current week's Torah portion (parsha)
 * @param {bool} useIsraelReading use Israel (true) or diaspora (false)
 * @param {Date} customDate Optional date to get parsha for (default now)
 * @return {ParshaInfo} containing parsha information
 */
export const getCurrentParsha = (
  useIsraelReading = false,
  customDate?: Date
): ParshaInfo => {
  try {
    // Get date (either provided date or today)
    const date: Date = customDate || new Date();

    // Convert to Hebrew date
    const hdate: HDate = new HDate(date);

    // Create a Sedra object for this year
    const sedra: Sedra = new Sedra(hdate.getFullYear(), useIsraelReading);

    // Get the current parsha
    const parsha: string = sedra.getString(hdate);

    // Return parsha information
    return {
      date: date.toISOString(),
      hebrewDate: hdate.toString(),
      parsha: parsha,
    };
  } catch (error) {
    // Re-throw the error with additional context
    throw new Error(`Failed to get parsha information: 
    ${error instanceof Error ? error.message : "Unknown error"}`);
  }
};
