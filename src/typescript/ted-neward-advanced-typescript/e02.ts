import { log } from "./utils";

function getNameOrNum(): string | number {
  return (Date.now() % 2) === 0 ? "Twenty Seven" : 27;
}

let norn = getNameOrNum();

//
// Using type assertion. <1>
//
log(norn.valueOf());

// <2>
if ((<string>norn).substring) {
  log((<string>norn).substring(0, 5));
} else if ((<number>norn).toFixed) {
  log((<number>norn).toFixed(2));
}
