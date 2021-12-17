let x: { name: string };
let y: { name: string, age: number };
let z: any = {
  name: "Fred",
  lastName: "Flinstone",
  age: 50000,
};

x = { name: "Ted" };
y = { name: "Ted", age: 45 };

//
// OK
//
x = z;
y = z;
x = y;

//
// NOK
//
//   y = x; <1>
//
// Property 'age' is missing in type '{ name: string; }' but
// required in type '{ name: string; age: number; }'
//
