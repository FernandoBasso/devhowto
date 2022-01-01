type TypeName<T> =
  T extends string ? "string" :
  T extends number ? "number" :
  T extends boolean ? "boolean" :
  T extends null ? "null" :
  T extends undefined ? "undefined" :
  T extends Function ? "function" :
      "object";

type T0 = TypeName<string>;         // "string"
type T1 = TypeName<number>;         // "number"
type T2 = TypeName<boolean>;        // "boolean"
type T3 = TypeName<null>;           // "null"
type T4 = TypeName<undefined>;      // "undefined"
type T5 = TypeName<() => void>;     // "function"
type T6 = TypeName<Array<RegExp>>;  // "object"
