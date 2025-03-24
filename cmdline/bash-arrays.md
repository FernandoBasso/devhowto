# Bash Arrays

## Serialize and Store Bash Array to a File

Let's save the array `nums` below as NUL-separated values in `nums.dat`

``` bash
$ nums=(1 2 3 4)
$ printf '%s\0' > nums.dat
```

If you `less nums-arr.dat` or open it in vim or emacs, it'll show like this:

``` text
1^@2^@3^@4^@
```

The numbers are the numbers we stored 🤣, and the "^@" is not a caret followed by an at sign, but a visual representation of the NUL. Just that when some tools wants to display them, they have to use something visible and the convention is to use "^@", which many tools do.

We can also inspect the file with `od`:

``` shell-session
$ od -cax nums.txt
0000000   1  \0   2  \0   3  \0   4  \0
          1 nul   2 nul   3 nul   4 nul
           0031    0032    0033    0034
```

Anyway, we serialized our array and stored it in a file.

## Deserialize Bash Array From a File

How to deserialize the contents of `nums.dat` and turn it back into code‽ By using `mapfile`.

### Using mapfile

To deserialize the data and turn it back into code -- an array -- we use `mapfile`:

``` shell-session
$ IFS= readarray -d '' them < nums-arr.dat
$ printf '%d\n' "${them[@]}"
1
2
3
4
```

### Why can't we use read‽

If we try `read` instead of `mapfile`, we see it doesn't work:

``` shell-session
$ IFS= read -ra nums < nums.txt

$ printf '%d\n' "${nums[@]}"
1234

$ IFS=\\0 read -ra nums < nums.txt

$ printf '%d\n' "${nums[@]}"
1234
```

It seems even using `IFS=\\0` or `IFS='\0'` don't work. Let's use this to learn more about both `read` and `mapfile`, shall we‽

> [!NOTE]
> `readarray` is an alias to `mapfile`

### Understanding mapfile vs read

So, why does `read -a -d ''` does not work, while `mapfile -d ''` does‽

First let's see what `read` and `mapfile` are supposed to do.

`help read` says:

> "Read a line from the standard input and split it into fields."
>
> Reads a single line from the standard input, or from file descriptor FD if the -u option is supplied. The line is split into fields as with word splitting, and the first word is assigned to the first NAME, the second word to the second NAME, and so on, with any leftover words assigned to the last NAME. Only the characters found in \$IFS are recognized as word delimiters."
>
> -- help read

And `help mapfile` says:

> "Read lines from the standard input into an indexed array variable.
>
> Read lines from the standard input into the indexed array variable ARRAY, or from file descriptor FD if the -u option is supplied. The variable MAPFILE is the default ARRAY."
>
> -- help mapfile

The important bits for our case is that `read` **reads a single line**, and `mapfile` reads **reads lines**. Note the plural on “lines” is a very important detail here.

Now let's scrutinize the `-d` option of both commands.

`help read` says:

``` text
-d delim  continue until the first character of SELIM is
read, rather than newline
```

`help mapfile` says:

``` text
-d delim  Use DELIM to terminate lines, instead of newline
```

OK, so `-d` does the same thing for both commands. They use the delimiter in `-d DELIM` to indicate what character should be used to indicate line termination, rather than `\n`.

That means `read -d ''` will read the first value of our NUL-separated input and consider it *a line* of input, and be done with it (after all, `read` “reads a single line of input”).

`mapfile` will also read the first value of our NUL-separated input and consider it *a line* of input, but rather than be done with it at this point, it will continue reading more likes (after all, `mapfile` “reads multiple lines of input”).

### IFS= and \0

One thing to consider is that variables cannot hold `NUL` Also, in

But:

``` shell-session
$ printf a\\0b | od -A n -tac
a nul   b
a  \0   b
```

It wouldn't be particularly useful if variables could store `NUL` since the point of a variable is usually to be used in the environment or as an argument to a command, where NULs are not accepted either.

`printf` interprets `\0` but `IFS=\\0` is something different.

The [spec](https://pubs.opengroup.org/onlinepubs/009604499/utilities/xcu_chap02.html#tag_02_05_03) says: “Variables shall be initialized from the environment”.

And we can't have NUL in the environment.

> [!NOTE]
> This topic is hard and has tormented me for a long time 😅.

Fernando-Basso About "variables cannot hold NUL", 2.5 Paramater and Variables states that "A parameter is set if it has an assigned value (null is a valid value)." And "a variable is a parameter denoted by name". The more I try to understand, the more I do not understand.

Soliton they mean empty string with null there.

phogg Fernando-Basso: a variable set to an empty string is indistinguishable from a variable set to null.

Soliton i think they should just write empty string but...

phogg probably should, but if you write a lot of C it can be hard to notice mistakes like that I assume that in the implementation there is a struct for the variable and it can be allocated (var defined) or not (var undefined), even if the allocated struct has a NUL where the value would go. From that POV it makes sense. none of it means that the user can put a NUL into a variable

### field separator vs terminator

We also have to be clear on the fact that **field separator** is different than **terminator**. A *terminator* could indicate the end of input, end of a line, etc. An input could be separated into multiple fields, and each field could be an entire line, so multiple lines would mean multiple fields.

Some people say that it makes more sense to use `\n` as field separator and `\0` (NUL) as terminators rather than the other way around.

## Serialize a NUL-separated list of files to a variable

``` shell-session
$ mapfile -td '' files < <(find ... -print0)
$ printf %s\\0 "${files[@]}"
```
