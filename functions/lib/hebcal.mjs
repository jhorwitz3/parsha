"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.getCurrentParsha = void 0;
const core_1 = require("@hebcal/core");
/**
 * Gets the current week's Torah portion (parsha)
 * @param {bool} useIsraelReading use Israel (true) or diaspora (false)
 * @param {Date} customDate Optional date to get parsha for (default now)
 * @return {ParshaInfo} containing parsha information
 */
const getCurrentParsha = (useIsraelReading = false, customDate) => {
    try {
        // Get date (either provided date or today)
        const date = customDate || new Date();
        // Convert to Hebrew date
        const hdate = new core_1.HDate(date);
        // Create a Sedra object for this year
        const sedra = new core_1.Sedra(hdate.getFullYear(), useIsraelReading);
        // Get the current parsha
        const parsha = sedra.getString(hdate);
        // Return parsha information
        return {
            date: date.toISOString(),
            hebrewDate: hdate.toString(),
            parsha: parsha,
        };
    }
    catch (error) {
        // Re-throw the error with additional context
        throw new Error(`Failed to get parsha information: 
    ${error instanceof Error ? error.message : "Unknown error"}`);
    }
};
exports.getCurrentParsha = getCurrentParsha;
//# sourceMappingURL=hebcal.mjs.map