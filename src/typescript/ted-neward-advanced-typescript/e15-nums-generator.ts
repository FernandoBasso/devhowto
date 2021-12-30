import { log } from "./utils";

function* infiniteSeq() {
  var n = 0;
  while (true) yield n++;
}

//
// WARNING: This is an infinite loop! YOU HAVE BEEN WARNED!
//
for (let i of infiniteSeq())
  log(i);
