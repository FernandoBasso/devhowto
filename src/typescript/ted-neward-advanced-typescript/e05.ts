import { l } from "./utils";

function padLeft(
  value: string,
  padding: string | number | never,
): string {
  if (typeof padding === "number") { // <1>
    return Array(padding + 1).join(' ') + value;
  }

  return padding + value; // <2>
}

l(padLeft('Master Yoda', '--- '));
// → --- Master Yoda

l(padLeft('Master Yoda', 4));
// →     Master Yoda
