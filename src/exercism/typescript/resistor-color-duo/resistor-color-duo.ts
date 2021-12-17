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
 * NOTE: Parse no more than two colors. Exceeding input colors shall
 * simply be ignored.
 *
 * ASSUME: The input color strings are valid color strings.
 *
 * @param colors The array of colors to map.
 * @param  maxColors The max number of colors to use from the
 *   input array.
 * @returns The numeric representation of the colors.
 */
export function decodedValue(
  colors: Colors[],
  maxColors: number = 2
): number {
  const values: number[] = colors
    .slice(0, maxColors)
    .map((color: Colors): number => {
      return colorDuos[color];
    });

  return Number(values.join(""));
}
