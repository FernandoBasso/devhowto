// <1>
function sealed(ctor: Function): void {
  Object.seal(ctor);
  Object.seal(ctor.prototype);
}

// <2>
@sealed
class Greeter {
  protected greeting: string;

  constructor(message: string) {
    this.greeting = message;
  }

  greet(): string {
    return `Hello, ${this.greeting}!`;
  }
}

// <3>
interface Greeter {
  goodBye(): string;
}

// <4>
Greeter.prototype.goodBye = function goodBye (): string {
  return 'Good-bye cruel world...';
}
// → TypeError: Cannot add property goodBye, object is not extensible
