---
description: An example of using sed to fill empty CSV fields with a space so it can be properly consumed by other tools, like the column command.
---

# Sed to Fill empty CSV fields with a blank space

## Intro & Motivation

I was using the `column` command to columnate data similar to this:

```{code} text
:caption: sample data
ID,NAME,POWER,SHIELD
1,Yoda,100,100
2,,,80
3,Aayla,97,58
4,,70,
5,Ahsoka,75,88
```

Of special importance for this example are the empty fields.

GNU `column` command worked as I expected:

```{code} text
:caption: GNU column output
$ column -ts, ./data.csv 
ID  NAME    POWER  SHIELD
1   Yoda    100    100
2                  80
3   Aayla   97     58
4           70
5   Ahsoka  75     88
```

80 was correctly placed on the SHIELD column for ID 2, and 70 was correctly placed on column POWER for ID 4.

But macOS `column` has a simpler implementation, and it ignored the empty fields, placing data in the wrong columns:

```{code} text
:caption: macOS column output
$ column -ts, ./data.csv 
ID  NAME    POWER  SHIELD
1   Yoda    100    100
2   80
3   Aayla   97     58
4   70
5   Ahsoka  75     88
```

Observe that 80 for ID 2, and 70 for ID 4 are all in the incorrect NAME column.

## Sed to the rescue

One possible solution would be to first use fill in those empty fields with an empty space (or some other character or characters that would not mess up with our data) so that `column` on macOS will not consider them to be empty fields.
Let's do it with `sed`.
First, let's try with a sample input:

```{code} text
$ echo '2,,,80' | sed 's/,,/, ,/g'
2, ,,80
```

It doesn't add a space on the second pair of ",,".
What gives?
The problem is that sed matches the first pair of ",," and moves on.
Visually, we can represent what happened with something like this:

```{code} text
[],,, => [,,], => (, ,), => , ,[,] => end
```

So even with the `g` modifier for the replacement, it ony matches the first pair of ",,".

One solution with sed is to use a label and jump until no more matches are possible:

```{code} text
:caption: sed label and jump to loop over matches

$ echo '2,,,80' | sed ':b; s/,,/, ,/; t b;'
2, , ,80
```

Or this other solution, courtesy of Earnestly on the #sed libera IRC channel:

```{code} text
$ echo '2,,,80' | sed 's/,\(,[^,]\)\{0,\}/, \1/g'
2, , ,80
```

In either case, we now have a sed command to fill the empty fields.
Test it with the data file itself:

```{code} text
$ sed ':b; s/,,/, ,/; t b;' ./data.csv
ID,NAME,POWER,SHIELD
1,Yoda,100,100
2, , ,80
3,Aayla,97,58
4, ,70,
5,Ahsoka,75,88
```

Yeah, now we have spaces between ", ," where we originally had ",,".

## Final, working solution

Finally, let's pass that output to `column` and tell it to use the comma `,` as the separator for `-t`:

```{code} text
$ sed ':b; s/,,/, ,/; t b;' ./data.csv | column -t -s,
ID  NAME    POWER  SHIELD
1   Yoda    100    100
2                  80
3   Aayla   97     58
4           70
5   Ahsoka  75     88
```

This works both on macOS sed and GNU sed.

:::{tip}
Just make sure that `-s` is directly followed by `,`, which is the separator.
That said, we could write the `column` command itself in a few slightly different ways:

- `column -ts,`
- `column -t -s ,`
- `column -t -s ','`

The `-s` and the delimiter could come before `-t` as well.
:::

