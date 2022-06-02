---
title: Data Types | PureScript
description: Let's scrutinize the creation and use of Data Types in PureScript and learn about the concepts behind them.
---

# Data Types

To create a new Data Type we use the `data` keyword:
```purs
data Foo = Foo

x :: Foo
x = Foo
```

![Data Types Example 1](data-types.assets/data-types-1.svg)

The type `Foo` has one inhabitant, `Foo`.

We can use the same name on the left, as the Data Type, and on the right as the Data Constructor because they are stored in different namespaces.

