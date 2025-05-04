---
description: Notes, tips and ideas on the `iota` numeric type in Go.
---

# Go Iota

## Intro and untyped integer

The spec for `iota` starts with this sentence (as of Go 1.24):

> Within a constant declaration, the predeclared identifier iota represents successive untyped integer constants.
>
> -- https://go.dev/ref/spec#Iota

How come it is _untyped_ if they are saying it is an _integer_?

This is the answer from [truckdad in the Go Discord server](https://discord.com/channels/118456055842734083/118456055842734083/1368551380666548357):

> The idea of an untyped integer is well-defined in the spec; informally, it means it has not yet been assigned an actual type in the language, like `int` or `uint8` (among other concrete integer types).
> It’s still an integer for purposes of its default type and operations that can be performed on it as a constant expression.

In some ways, the concept of an _untyped integer_ is similar to the `Num` type constraint in Haskell, where it constrains the value to be of some kind of number, but it making it a concrete type like `Int`, `Integer`, `Float`, etc.
If we have (in Haskell), the values `x` and `y` constrained by `Num`, we know we can perform `+`, `-` and similar operations on those values, but it is not yet known which concrete numeric type they really are.

In Go, this constraint could be implemented with an approach like in this example:

```{code} go
package main

import "fmt"

type Num interface {
	int | int8 | int16 | int32 | int64 |
		uint | uint8 | uint16 | uint32 | uint64 |
		float32 | float64
}

func Add[N Num](a, b N) N {
	return a + b
}

func main() {
	fmt.Println(Add(0.1, -1))
	//=> -0.9
}
```

Check the [spec section on Constants](https://go.dev/ref/spec#Constant) for the precise details.

We can rant a little bit and argue that _untyped integer_ is not a good name for the idea, as arguably, _integer_ in programming languages and type systems _does_ imply (or concretely means) a type.
What the Go spec means about _untyped integer_ is more like a constraint, or a not-fully-realized integer type, or a loosely typed integer.
That said, we know understand this topic a little more 😉.
