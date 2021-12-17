type F1 = (x: string, y: string) => void;
type F2 = (x: number, y: number) => void;

const f: F1 & F2 = function f (
  x: string | number,
  y: string | number,
): void {
  // function body
};

// OK <1>
f("foo", "bar");

// OK <2>
f(1e1, 1e2);

// NOK <3>
// f(1, "bar"); // <4>
// f("foo", 2); // <5>
