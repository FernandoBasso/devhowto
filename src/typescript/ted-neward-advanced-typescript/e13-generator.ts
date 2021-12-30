import { log } from "./utils";

function* names() {
  yield "Yoda";
  yield "Ahsoka";
  yield "Obi-Wan";
  yield "Aayla";
}

for (let name of names())
  log(name);
// → Yoda
// → Ahsoka
// → Obi-Wan
// → Aayla
