type MethodDecoratorFn = (
  target: unknown,
  name: string,
  descr: PropertyDescriptor
) => void;

function enumerable(isEnumerable: boolean): MethodDecoratorFn {
  return function enumerableDecorator(
    target: unknown,
    name: string,
    descr: PropertyDescriptor
  ) {
    descr.enumerable = isEnumerable;
  };
}

export class Greeter {
  protected greeting: string;

  constructor(message: string) {
    this.greeting = message;
  }

  @enumerable(false)
  protected greet(): string {
    return `Hello, ${this.greeting}!`;
  }
}
