---
description: Notes, tips and examples on Lisp strings, including some approaches to formatting other data types as strings.
----

# Lisp Strings

## Simple strings
#lisp #string

```lisp
(defparameter msg "Hello, World!")
```

Strings are always in double quotes.
The single quote is for Lisp's _quoting_ mechanism and cannot be used to create string literals as in some other languages like JavaScript, Python or PHP.

## Quotes in strings
#string #quote

Escape double quotes that must be part of string (and not delimit the string):

```lisp
(defparameter sentence "She said, \"Go away!\", and started crying.")
```

## Multi-line strings
#multiline #string

Multi-line strings can be created without any special syntax, like in other languages were we are required to escape newlines with a backslash `\`.

```lisp
(defparameter usage "Usage: fn [OPTIONS]

  -h              Display this help and exit.
  -H hostname     Hostname to connect.
  -v              Verbose mode.
")
```

## Newlines
#lisp #string #newline

Lisp came way before the C and the C-family syntax.
This is part of the reason it _does not_ use `\n` for newlines, but `~%`.
Example:

```lisp
(format t "One~%Two~%Three~%")
One
Two
Three
```

## Concatenate strings
#lisp #string #concatenate #cat

Use `concatenate` to combine strings:

```lisp
(concatenate 'string "May" "the force" "be with" "you")
"Maythe forcebe withyou
```

Note that it doesn't add spaces between the concatenated strings.
We must take care of the spaces ourselves.
For example, here we add a space at the beginning of every next string to be concatenated.

```lisp
(concatenate 'string "May" " the force" " be with" " you")
"May the force be with you"
```


- [concatenate function in the hyperspec](https://www.lispworks.com/documentation/HyperSpec/Body/f_concat.htm).
