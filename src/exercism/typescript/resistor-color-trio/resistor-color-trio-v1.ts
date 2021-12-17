type Colors =
  | "black"
  | "brown"
  | "red"
  | "orange"
  | "yellow"
  | "green"
  | "blue"
  | "violet"
  | "grey"
  | "white";

type ColorDuos = {
  [key in Colors]: number;
};

const colorDuos: ColorDuos = {
  black: 0,
  brown: 1,
  red: 2,
  orange: 3,
  yellow: 4,
  green: 5,
  blue: 6,
  violet: 7,
  grey: 8,
  white: 9,
};

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
 * @param colors The array of colors to map.
 * @returns The numeric representation of the colors.
 */
export function decodedResistorValue(colors: Colors[]): string {
  const num: number = Number(
    colors
      .slice(0, 2)
      .map((color) => colorDuos[color])
      .join("")
  );

  const exponent: number = colorDuos[colors[2]];
  const powered: number = num * 10 ** exponent;

  if (powered < 1e3) {
    return `${powered} ohms`;
  }

  return `${powered / 1e3} kiloohms`;
}
