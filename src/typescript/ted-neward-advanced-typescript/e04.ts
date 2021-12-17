import { log } from "./utils";

function padLeft(
  value: string,
  padding: string | number | never,
): string {
  if (typeof padding === "number") {
    return Array(padding + 1).join(' ') + value;
  }

  if (typeof padding === 'string') {
    return padding + value;
  }

  throw new TypeError(`Expected string or number, got ‘${padding}’.`);
}

log(padLeft('Master Yoda', '--- '));
// → --- Master Yoda

log(padLeft('Master Yoda', 4));
// →     Master Yoda

// log(padLeft('Master Yoda', /re/))
// → TypeError: Expected string or number, got ‘/re/’.
