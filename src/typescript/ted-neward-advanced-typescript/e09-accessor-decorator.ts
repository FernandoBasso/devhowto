import { log } from "./utils";

type AccessorDecoratorFn = (
  target: unknown,
  name: string,
  descr: PropertyDescriptor
) => void;

function trace(msg: string): AccessorDecoratorFn {
  return function enumerableDecorator(
    target: unknown,
    name: string,
    descr: PropertyDescriptor
  ) {
    const getter = descr.get || function () {};

    // <1>
    descr.get = function getFn() {
      log(`${name}:`, msg);
      return getter.call(this);
    };
  };
}

export class Point {
  private _x: number;
  private _y: number;

  constructor(x: number, y: number) {
    this._x = x;
    this._y = y;
  }

  @trace('getting x')
  get x() {
    return this._x;
  }

  @trace('getting y')
  get y() {
    return this._y;
  }
}

const p = new Point(-3, 4);
log(p.x, p.y);

