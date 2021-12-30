import { log } from "./utils";

function* namesGen() {
  yield "Yoda";
  yield "Ahsoka";
  yield "Obi-Wan";
  yield "Aayla"
}

const names = namesGen();

// <1>
for (let name of names)
  log(name);
// → Yoda
// → Ahsoka
// → Obi-Wan
// → Aayla

//
// LOOK AT WHAT HAPPENS NOW:
//
log(names.next());
// → { value: undefined, done: true }

log(namesGen().next());
// → { value: 'Yoda', done: false }
