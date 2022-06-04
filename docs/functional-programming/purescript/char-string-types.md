---
title: Char and String Types | PureScript
description: Learn about PureScript Char and String types, their use and some useful tips and considerations about them.
---

# Char and String Types

## Char

The `Char` type is written in single quotes. We can also use Unicode code points in hexadecimal to create a char. Note the `\x...` escape sequence.

```haskell
charZ :: Char
charZ = 'Z'

check :: Char
check = '\x2714'
-- → ✔
```

## String

The `String` type is written with double quotes.

Unlike in some other languages, line continuation requires not one escape, but two.

```haskell
hello :: String
hello = "Hello, world!"

withNl :: String
withNl = "Contains a\nnewline."
```

Multi-line:

```haskell
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

## Unicode

We can use `\x` escapes with hexadecimal numbers to denote a Unicode code point.

### Char

For `Char`, as of PureScript 0.15, it seems we can use up to 4 bytes:

```text
> '\x2714'
'✔'

> '\x2717'
'✗'

> '\x03bb'
'λ'

> '\x203d'
'‽'

> '\x0001f4a9'
Unexpected a at line 1, column 10
> '\x1f4a9'
Illegal astral code point in character literal at line 1, column 9
```

### String

For `String`, we can use up to 6 bytes (which as of 2022, is enough every Unicode code point without using surrogates, since as of this day, Unicode goes up to 10FFFF).

```text
> "\x2714"
"✔"

> "\x1f4a9"
"💩"

> "\x01f4a9"
"💩"

> "\x0001f4a9"
"Ǵa9"
```

Surrogates work with `String`, but not with `Char`:

```
> "\xD83d\xDCA9"
"💩"

> '\xD83d\xDCA9'
Unexpected \ at line 1, column 8
```

See [this discussion on the PureScript Discord server](https://discord.com/channels/864614189094928394/865617619464749081/981167025546227812) about this topic and [this issue on the PureScript repo](https://github.com/purescript/purescript/issues/3750).

