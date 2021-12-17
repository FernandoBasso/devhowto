import { log } from "./utils";

function getNameOrNum(): string | number {
  return (Date.now() % 2) === 0 ? "Twenty Seven" : 27;
}

// <1>
function isString(value: string | number): value is string {
  return (<string>value).substring !== undefined;
}

let norn = getNameOrNum();

//
// Using type guards. <2>
//
if (isString(norn)) {
  log(norn.substring(0, 5));
} else {
  log(norn.toFixed(2));
}
