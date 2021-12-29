import { log } from "./utils";

function trace(msg: string) {
  return function traceDecorator(target: unknown, name: string) {
    log(name, msg, target);
  };
}

class Point {
  @trace('accessed')
  public x: number;

  @trace('accessed')
  public y: number;

  constructor(xx: number, yy: number) {
    this.x = xx
    this.y = yy;
  }
}

const p = new Point(-3, 4);

log(
  p.x,
  p.y,
);
// → x accessed {}
// → y accessed {}
// → -3 4

// Will not trigger the decorator.
p.x = -2;
p.y = 3;

// Will not trigger the decorator.
log(
  p.x,
  p.y,
);
