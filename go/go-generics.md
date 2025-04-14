---
description: Concepts, notes, ideas and examples on Go generics and their usage.
---

# Go Generics

## Intro

Go 1.18 introduced generics support.
From that version, functions can take generic (parametrically polymorphic) types, and interfaces got the ability to describe union types.

## min(x, y) for go 1.18

```{code} text
:filename: go.mod
module main

go 1.18

require golang.org/x/exp v0.0.0-20250128182459-e0ece0dbea4c
```

```{code} go
:filename: main.go
package main

import (
	"golang.org/x/exp/constraints"
	"fmt"
)

func min[T constraints.Ordered](x, y T) T {
	if x < y {
		return x
	}

	return y
}

func main() {
	fmt.Println(min[int](3, 2))
	// => 2

	fmt.Println(min[string]("xyz", "klm"))
	// => klm

	// '_' is 95, '0' is 48 (like in C/ASCII)
	fmt.Println(min[rune]('_', '0'))
	// => 48
}
```

Observe that we pass the concrete type when calling `min`, like `min[int](...)`, `min[string](...)` and `min[rune](...)` in our example.
Providing that concrete type while calling the function is called _instantiation_.

Instantiation happens in two steps:

* Substitute type argument for type parameters.
* Check that type arguments implement their constraints.

And if step two fails, instantiation itself fails.

:::{note}
Due to type inference, it is not always required to pass the concrete type while calling the function.
Instantiation can infer types most of the time.
It means this could would also work:

```go
fmt.Println(min(3, 2))
// => 2

fmt.Println(min("xyz", "klm"))
// => klm

// '_' is 95, '0' is 48 (like in C/ASCII)
fmt.Println(min('_', '0'))
```
:::

## Go 1.21 cmp.Ordered

From Go 1.21, `cmp.Ordered` is the type we should use:

```go
import "cmp"

func min[T cmp.Ordered](x, y T) T {
	if x < y {
		return x
	}

	return y
}
```

The instantiation and usage is the same as the previous example with `constraints.Ordered`.

## Instantiation examples

It is possible to instantiate the generic function with a concrete type (without actually calling it).
The instantiation produces a non-generic function, which can be assigned to a variable for later use.

```go
var minInt8 = min[int8]
var minStr = min[string]

func main() {
	fmt.Println(minInt8(7, 2))
	// => 2

	fmt.Println(minStr("abc", "KLM"))
	// KLM
}
```

## Generic structs

### Example with a binary tree

```go
type Tree[T any] struct {
	left, right *Tree[T]
	data        T
}
```

Then we could implement methods on `Tree`:

```go
func (t *Tree[T]) Find(v T) *Tree[T] {
	// Logic to find v.
}
```

And create concrete-typed instances from the generic `Tree[T]`.
That is, we can instantiate `T` to any concrete type that (in our example), satisfies the `cmp.Ordered` interface:

```go
var sTree Tree[string]
var iTree Tree[int64]
```

:::{note}
Remember that `any` is short for `interface{}`.
:::

## Type sets and type constraints

An ordinary parameter list has a type for each parameter.
This type defines a set of values that inhabit that type (all possible strings, or all possible integer numbers, etc.)

```go
func min(x, y int64) int64 {
	// ...
}
```

In the `min()` function above, `int64` is the type for both `x` and `y`, it it means that both `x` and `y` can take any of the values that inhabit the `int64` type.

Compare with this:

```go
func min[T cmp.Ordered](x, y T) T {
	// ...
}
```

In this case, the type parameter list also has a type for each parameter.
It is called a _type constraint_, and it defines a _set of types_.
It is called _type constraint_ because it _constrains_ the types that it accepts.
In this example, the `cmp.Ordered` (or `constraints.Ordered in Go 1.18 and 1.19) type constraint means that `T` can be any type that allows its values to be ordered in some way, and therefore, be compared in terms of which value domes first or after the other value in some sense.

It means integers, strings, floats satisfy `cmp.Ordered` and therefore are valid values to be passed to `min()`, but types like booleans or struct do not satisfy `cmp.Ordered`, and therefore would not be valid input values to `min()`.

:::{note}
As of this writing (Feb 2024 and Go 1.23), the type `bool` does implement comparison operators.
That is, we cannot do things like this:

```go
if false < true
// ~ invalid operation: false < true (operator < not
// ~ defined on untyped bool)

// Or

x := min[bool](false, true)
// ~ bool does not satisfy cmp.Ordered (bool missing in ~int |
// ~ ~int8 | ~int16 | ~int32 | ~int64 | ~uint | ~uint8 | ~uint16 |
// ~ ~uint32 | ~uint64 | ~uintptr | ~float32 | ~float64 | ~string)
```

Therefore, `bool` is a type that does not satisfy `cmp.Ordered` constraint.
:::

## Type constraints are interfaces

An interface defines a set of methods.
Any type that implements that set of methods implements that interface.

Another way to look at it is that an interface defines a set of types, which is where the following syntax in Go comes from:

```go
type MyType interface {
	T1 | T2 | Tₙ
}
```

Operators like `<` or `>` are not methods.
So how come type constraints are interfaces?

```go
type Ordered interface {
	Integer | Float | ~string
}
```

:::{note}
Note that there are no methods in the `Ordered` interface.
It is really just defining a set of types.
:::

The vertical bar expresses an union of the types.
`Integer` `Float` are interfaces themselves.

The _tilde_ “~” is a new token introduced in Go 1.18.
In short, it means `~T` the set of all types with underlying type `T`.
In our example, `~string` means all types that have the underlying `string` type.

A type constraint has two functions:

* The type set of type constraint is the set of all valid type arguments.
* If all types in a constraint support a certain operation, that operation may be used with the respective type parameter (even though there are exceptions or restrictions to this for a few special cases).

## Constraint literals (inline constraints)

Take this type constraint (with inline interfaces):

```go
[S interface{ ~[]E }, E interface{}]
```

Go 1.8 added some syntax sugar so `interface{ ~[]E }` can be shortened to simply `~[]E`, so the type constraint can be written as:

```go
[S ~[]E, E interface{}]
```

Also, the empty interface `interface{}` got an alias `any`, the type constraint can be even written like this:

```go
[S ~[]E, any]
```

## Scale() function example

### Non-working implementation

Let’s consider this piece of code:

```go
package main

import (
	"fmt"
	"golang.org/x/exp/constraints"
)

// scale takes a slice of Integer and returns a new slice with each
// integer multiplied by k.
func scale[E constraints.Integer](s []E, k E) []E {
	scaled := make([]E, len(s))

	for i, v := range s {
		scaled[i] = v * k
	}

	return scaled
}

// Point represents the coordinates of a point.
type Point []int32

// Str returns a stringified version Point p.
func (p Point) Str() string {
	var s string

	for _, v := range p {
		s += string(v) + " "
	}

	return s
}

func main() {
	xs := Point{2, 3, 4}

	scaledXs := scale(xs, 2)

	// ERROR: Doesn't compile.
	fmt.Printf("%s\n", scaledXs.Str())
	// ~ scaledXs.Str undefined (type []int32 has no field or method Str)
}
```

The problem with this implementation is that `scale()` returns a `[]E`, where `E` is the element type of the argument slice.

When we call `scale()` with a value of type `Point`, whose underlying type is `[]int32`, we get back a value of type `[]int32`, not a value of type `Point`.
The problem here is that `Point` has the method `Str()`, but `[]int32`` does not, thus the error.

<dl><dt><strong>📌 NOTE</strong></dt><dd>

This is one more reason why I generally prefer explicit type annotations.
So instead of:

```text
v := someFn(x)
```

We would do something like this:

```text
var v SomeType = someFn(x)
```

If `somFn()` does NOT return `SomeType``, we know immediately, either through the editor feedback or when testing or compiling the code.

Explicit type annotations make the expected type immediately visible, and we don’t need to be in an editor/IDE with LSP or some other tool to help with hovers or whatever to inspect the returned types.
It becomes visible and explicit even in a plain text file, cat, Gitlab, etc.
</dd></dl>

### Working implementation

The fix is simple: we simply use more appropriate types and things work.

```diff
- func scale[E constraints.Integer](s []E, k E) []E {
+ func scale[S ~[]E, E constraints.Integer](s S, k E) S {
-   scaled := make([]E, len(s))
+   scaled := make(S, len(s))

  for i, v := range s {
    scaled[i] = v * k
  }

  return scaled
}
```

We introduced a new type constraint `S ~[]E` (which is the type of the argument), so that the underlying type of its argument must be a slice of some element of type `E`.

With this change, the first argument of the function is of type `S`, rather than `[]E`.

But now if we call `scale(p, k)`, and `p` is of type `Point`, then the return type will also be of type `Point`, and `Point does have a method `Str()`.

And with those changes we have a proper, working implementation of `scale()` as the types now work as we actually need them to work.

## Type inference

This is how we can call `scale()`:

```go
xs := Point{2, 3, 4}

scaledXs := scale[Point, int32](xs, 2)

fmt.Printf("%s\n", scaledXs.Str())
```

We pass `Point` as the type constraint for `S` (`xs` parameter), and `int32` for the type constraint for `E` (`2` parameter).
But we can also call it without providing the type constraints explicitly, and the type checker will be able to correctly infer the types _from the parameters_ passed.

```go
xs := Point{2, 3, 4}
scale(xs, 2)
```

In this case, the type checker infers that the type constraint for `S` is `Point` (and ``Point`’s underlying type is `int32`).
The type constraint for `2` is `int32`.

All the type arguments are successfully inferred, so the function can be instantiated and called without explicit type arguments provided at the call site.

:::{note}
Depending on our setup, including linting, we may even get diagnostic messages saying we are providing _unnecessary_ type arguments, since in most situations type inference just works.

Whether it is good practice to be implicit instead of explicit is a controversial topic (I tend to err on the side of being explicit most of the time, though).
:::

## References

* [ GopherCon 2021: Generics! - Robert Griesemer & Ian Lance Taylor (Youtube)](https://www.youtube.com/watch?v=Pa_e9EeCdy8).
