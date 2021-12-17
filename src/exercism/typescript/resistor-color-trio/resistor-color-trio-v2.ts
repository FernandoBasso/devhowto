/**
 * Note the values are the indexes (zero-indexed):
 *
 *   black: 0 (index 0)
 *   brown: 1 (index 1)
 *   ...
 *   white: 9 (index 9)
 */
const colors = [
  "black",
  "brown",
  "red",
  "orange",
  "yellow",
  "green",
  "blue",
  "violet",
  "grey",
  "white",
] as const;

type Color = typeof colors[number];

/**
 * Map the color strings to their corresponding numbers and join
 * (concatenate, not add) the numbers together. 1 and 5 is 15, not 6.
 *
 * NOTE: Parse no more than three colors. Exceeding input colors
 * shall simply be ignored.
 *
 * ASSUME: The input color strings are valid color strings.
 *
 * ASSUME: Always precisely three colors are passed.
 *
 * @param colors The array of colors.
 * @returns The human-readable representation.
 */
export function decodedResistorValue([band1, band2, band3]: Color[]): string {
  const tens: number = colors.indexOf(band1) * 10;
  const ones: number = colors.indexOf(band2);
  const exponent: number = colors.indexOf(band3);
  const powered: number = (tens + ones) * 10 ** exponent;

  return powered < 1e3
    ? `${powered} ohms`
    : `${powered / 1e3} kiloohms`;
}
