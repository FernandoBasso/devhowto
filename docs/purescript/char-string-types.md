---
title: Char and String Types | PureScript
description: Learn about PureScript Char and String types, their use and some useful tips and considerations about them.
---

# Char and String Types

## Char

The `Char` type is written in single quotes. We can also use Unicode code points in hexadecimal to create a char. Notethe `\x...` escape sequence.

```purs
charZ :: Char
charZ = 'Z'

check :: Char
check = '\x2714'
-- → ✔
```



## String

The `String` type is written with double quotes.

Unlike in some other languages, line continuation requires not one escape, but two.

```purs
hello :: String
hello = "Hello, world!"

withNl :: String
withNl = "Contains a\nnewline."


```



Multi-line:

```purs
multi :: String
multi = "This string\
        \ spawns over\
        \ multiple lines, but spaces\
        \ to the \
        \ left of the ‘\\’ are ignored.\
        \\n\
        \ Oh, and Unicode code points\
        \ work too \x2714! 💖"
```

```text
> log multi
This string spawns over multiple lines, but spaces to the  left of the ‘\’ are ignored.
 Oh, and Unicode code points work too ✔! 💖
```

Spaces before the trailing `\` concatenate with spaces after the leading `\`.

TODO: How to write more than four hex digits? Ex: `\x0001f4a9` to get the Pile of Poo 💩‽
