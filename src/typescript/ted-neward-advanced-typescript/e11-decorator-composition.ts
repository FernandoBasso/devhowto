import { log } from "./utils";

function f() {
  log("f() evaluated");
  return function fDecorator(
    target: unknown,
    name: string,
    descr: PropertyDescriptor
  ) {
    log("f() called", name, target);
  };
}

function g() {
  log("g() evaluated");
  return function gDecorator(
    target: unknown,
    name: string,
    descr: PropertyDescriptor
  ) {
    log("g() called", name, target);
  };
}

class C {
  @f()
  @g()
  method() {
    log("method called");
  }
}

const c = new C();
c.method();
// → f() evaluated
// → g() evaluated
// → g() called method {}
// → f() called method {}
// → method called

