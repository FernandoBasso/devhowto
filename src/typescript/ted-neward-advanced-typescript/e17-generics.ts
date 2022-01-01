import { log } from "./utils";

function identity<Type>(arg: Type): Type {
  return arg;
}

//
// `id` is a reference to `identity`. Note that we used an anonymous
// interface or anonymous object type to give an explicity type to `id`.
//
const id: { <Type>(arg: Type): Type } = identity;

log(id<number>(1));
log(id<Array<string>>(["hello", "world"]));
