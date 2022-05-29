---
title: TypeScript Functions
---


# TypeScript Functions

## Matching the type

### A refresher on JavaScript function arguments

Consider:

```js
function f() {
  // Code goes here.
}

f();
f(1, "hello");

function g(x, y) {
  // Handle what to do if either ‘x’
  // or ‘y’ or both are not provided.
}

g(1, 2);
g(1);
g();
g(1, 2, 3, 4, 5);
```

JavaScript does not prevent us from calling functions with less or more arguments than declared in the function signature. We will not get errors saying something like “expected two arguments but received none”, like in Ruby, Python and several other languages. You just have to make sure to handle the logic inside the function correctly.

Compare with Ruby and Python, for example:

```rb
def f(x, y)
  x + y
end

f

#
# $ ruby -w foo.rb 
# foo.rb:1:in `f': wrong number of arguments (given 0, expected 2)
# (ArgumentError)
#
```

```py
def f(x, y):
  x + y
  # Code goes here

f()

#
# $ python foo.py
# TypeError: f() missing 2 required positional arguments: 'x' and 'y'
#
```

If we have a type for a function, and we anotate a variable with that type, the implementation of the function does not necessarily need to match the type 

