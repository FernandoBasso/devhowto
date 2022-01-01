// <1>
class Names<Type = string> {
  constructor(protected data: Array<Type>) {}
}

class Name {
  constructor(protected segments: Array<String>) {}
}

// <2>
const simpleNames = new Names(["Ada", "Luna", "Margaret"]);

// <3>
const complexNames = new Names<Name>([
  new Name(["Ada", "Lovelace"]),
  new Name(["Luna", "Lovegood"]),
  new Name(["Margaret", "Hamilton"]),
]);
