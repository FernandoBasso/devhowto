---
title: HackerRank Shell Challenges and Solutions
---

# HackerRank Shell Challenges and Solutions

## Intro

Unless otherwise noted, assume all scripts contain the following shebang:

```
#!/usr/bin/env bash
```

## Easy Challenges

<https://www.hackerrank.com/domains/shell>

### Let’s Echo

Tags: \#cmdline \#shell \#bash \#echo \#printf Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials-lets-echo)

``` shell-session
$ echo HELLO

$ printf '%s\n' HELLO
```

### Looping With Numbers

- Tags: \#cmdline \#shell \#bash \#numbers \#looping \#for
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials---looping-with-numbers)

``` shell-session
for (( i = 1; i <= 9; ++i ))
do
  echo "$i"
done
```

Or using ranges:

``` shell-session
$ printf '%d\n' {1..50}
```

### Looping And Skipping

- Tags: \#cmdline, \#numbers \#looping \#for
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials---looping-and-skipping)

``` shell-session
for (( i = 1; i <= 9; ++i ))
do
  if (( i % 2 == 0 ))
  then
    continue
  fi
  echo "$i"
done
```

``` shell-session
$ bash script.sh
1
3
5
7
9
```

Could also use ‘’echo:’’

``` shell-session
$ echo -ne {1..9..2} '\n'
```

The `-e` option is to enable some escapes. `help echo` for more.

Or using `seq`:

``` shell-session
$ seq -s ' ' 1 2 9
```

### A Personalized Echo

- Tags: \#cmdline \#read \#echo
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials---a-personalized-echo)

``` shell-session
$ read -r name
$ printf 'Welcome %s\n' "$name"
```

### The World of Numbers

- Tags: \#cmdline \#shell \#bash \#numbers \#math \#bc \#ranges
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials---the-world-of-numbers)

First, see this clever use of range to produce the math expressions:

``` shell-session
$ read -r x y
8 2

$ printf '%s\n' "$x"{+,-,*,/}"$y"
8+2
8-2
8*2
8/2
```

Then, feed those expressions to `bc`:

``` shell-session
$ read -r x y
8 2

$ printf '%s\n' "scale=2; $x"{+,-,*,/}"$y" | bc
10
6
16
4.00
```

If `y` is *negative*, like `-2` we would receive an error:

``` shell-session
$ read -r x y
5 -2

$ printf '%s\n' "scale=2; $x"{+,-,*,/}"$y" | bc
3
(standard_in) 2: syntax error
-10
-2.50
```

Adding parenthesis prevents the error, because our expression would be like `5--2`, but `5-(-2)` is OK with `bc`:

``` shell-session
$ read -r x y
5 -2

$ printf '%s\n' "scale=2; $x"{+,-,*,/}"($y)" | bc
3
7
-10
-2.50
```

Or something more manual and verbose:

``` shell-session
read x </dev/stdin
read y </dev/stdin

printf '%d\n' $(( x + y ))
printf '%d\n' $(( x - y ))
printf '%d\n' $(( x * y ))
printf '%d\n' $(( x / y ))
```

NOTE: The challenge wants integer division, so, we simply omit `bc`’s scale special variable.

``` shell-session
read -r answer

case "$answer" in
  [Yy]*)
    printf '%s\n' YES
    ;;
  [Nn]*)
    printf '%s\n' NO
    ;;
  *)
    printf '%s\n' 'What the poop‽ 💩'
    ;;
esac
```

``` shell-session
$ bash script.sh
yes
YES

$ bash script.sh
Y
YES

$ bash script.sh
n
NO

$ bash script.sh
lol
What the poop‽ 💩
```

### Getting started with conditionals

- Tags: \#cmdline \#shell \#bash \#conditionals
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials---getting-started-with-conditionals)

``` shell-session
read -r answer

case "$answer" in
  [Yy]*)
    printf '%s\n' YES
    ;;
  [Nn]*)
    printf '%s\n' NO
    ;;
  *)
    printf '%s\n' 'What the poop‽ 💩'
    ;;
esac
```

``` shell-session
$ bash script.sh
yes
YES

$ bash script.sh
Y
YES

$ bash script.sh
n
NO

$ bash script.sh
lol
What the poop‽ 💩
```

### More on Conditionals

- Tags: \#cmdline \#shell \#bash \#conditionals \#math
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials---more-on-conditionals)

Solution based on side lengths.

- equilateral: x == y && y == z
- scalene: x != y && y != z && z != x
- isosceles: any other

``` shell-session
read -r x
read -r y
read -r z

[[ "$x" == "$y" ]] && [[ "$y" == "$z" ]] && echo EQUILATERAL && exit 0
[[ "$x" != "$y" ]] && [[ "$y" != "$z" ]] && [[ "$z" != "$x" ]] && echo SCALENE && exit 0
echo ISOSCELES && exit 0
```

### Arithmetic Operations

- Tags: \#cmdline \#shell \#bash \#math \#bc
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials---arithmetic-operations)

``` shell-session
expression="$1"
printf '%.3f\n' "$(echo "$expression" | bc -l)"
```

`bc -l` produces up to 6 decimal places. If we use `bc` scale to 3, for instance, depending on the result, we would produce wrong results because `printf %f` format specifier does rounding by itself.

`bc` scale is 0 by default if not explicitly set. Also, `bc` does no rounding.

`printf` rounds up from 6, and down from 5:

``` shell-session
$ printf '%.3f\n' 1.2583
1.258
$ printf '%.3f\n' 1.2585
1.258
$ printf '%.3f\n' 1.2586
1.259
```

Only when the number after 8 passes 5, that is, 6 and above, is that the number is rounded up to 1.259. If one uses `scale=3` in `bc`, then it truncates (does not round) to three decimal places and `printf` has no way to round up, making the solution to the exercise incorrect. Therefore, we use `bc -l` without scale, or use `scale=4` at least.

### Compute the Average

- Tags: \#cmdline \#shell \#bash \#math
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials---compute-the-average)

``` shell-session
read -r n
sum=0

if [[ "$n" == 0 ]]
then
  printf '%.3f\n' "$(echo 'scale=4; 0' | bc -l)"
  exit 0
fi

for ((i = 0; i < n; ++i))
do
  read -r x
  sum=$((sum + x))
done

printf '%.3f\n' "$(echo "scale=4; $sum / $n" | bc -l)"
```

We used `scale=4` by the same reasons described earlier about truncating and rounding.

### cut Challenges

- Tags: \#cmdline \#shell \#bash \#cut

``` shell-session
$ cut -b 3 -

$ cut -b 2,7 -

$ cut -b 2-7 -

$ cut -b 1-4 -

$ cut -d $'\t' -f 1,2,3 -

$ cut -c 13- -

$ cut -d ' ' -f 4 -

$ cut -d ' ' -f 1,2,3 -

$ cut -d $'\t' -f 2- -
```

### Head of Text File Challenges

``` shell-session
$ head -n 20

$ head -c 20
```

### Middle of a Text File

- Tags: \#cmdline \#shell \#bash \#sed
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-in-linux---the-middle-of-a-text-file)

``` shell-session
$ sed -n '12,22 p'
```

### Tail of a Text File 1 and 2

- Tags: \#cmdline \#shell \#bash \#tail
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-tail-1)

``` shell-session
$ tail -n 20 -

$ tail -c 20 -
```

### tr Command 1

- Tags: \#cmdline \#shell \#bash \#tr \#here-document \#assignment
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-tr-1)

``` bash
# Assign some text to the variable `input'.
$ read -r -d '' input << 'EOF'
int i = (int) 5.8;
int res = (23 + i) * 2;
EOF

# Inspect `input' contents.
$ echo "$input"
int i = (int) 5.8;
int res = (23 + i) * 2;

# Apply `tr' to `input' and see ( and ) replaced with [ and ].
$ echo "$input" | tr '()' '[]'
int i = [int] 5.8;
int res = [23 + i] * 2;
```

A [Here Document](https://www.gnu.org/software/bash/manual/bash.html#Here-Documents) is used to assign lines of text to the variable `input`.

### tr Command 2

- Tags: \#cmdline \#shell \#bash \#tr
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-tr-2)

``` shell-session
$ tr -d 'a-z'
```

### tr Command 3

- Tags: \#cmdline \#shell \#bash \#tr
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-tr-3)

``` shell-session
$ tr -s ' '
```

### sort Lines Challenges

- Tags: \#cmdline \#shell \#bash \#sort
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-sort-1)

``` shell-session
$ echo -e 'aa\nbb\naa\ncc\nff\ncc' | sort -
aa
aa
bb
cc
cc
ff

$ echo -e 'aa\nbb\naa\ncc\nff\ncc' | sort -r -
ff
cc
cc
bb
aa
aa

$ echo -e '2.1\n3\n0.2\n0' | sort -n -
0
0.2
2.1
3

$ echo -e '2.1\n3\n0.2\n0' | sort -nr -
3
2.1
0.2
0

# Sort by field 2, taking Tab as field separator.
$ sort -t $'\t' -nr -k 2 -

# Same, but in ascending order.
$ sort -t $'\t' -n -k 2 -

# This time the delimiter is a “|” character
$ sort -t '|' -nr -k 2 -
```

### uniq Challenges

- Tags: \#cmdline \#shell \#bash \#uniq
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-in-linux-the-uniq-command-1)

``` shell-session
$ uniq -
​```
```

Display the count of lines that were uniqfied and the uniqfied lines without leading whitespace/tabs:

``` shell-session
$ read -r -d '' lines << 'EOF'
> foo
> foo
> bar
> bar
> bar
> tux
> EOF

$ echo "$lines" | uniq -c - | sed 's/ \+\([0-9]\+ [^ ]\+\)/\1/'
2 foo
3 bar
1 tux

$ echo "$lines" | uniq -c - | sed 's/^[[:space:]]*//g'
2 foo
3 bar
1 tux

$ echo "$lines" | uniq -c - | cut -b 7- -
2 foo
3 bar
1 tux

$ echo "$lines" | uniq -c - | xargs -l
2 foo
3 bar
1 tux

$ echo "$lines" | uniq -c - | xargs -L 1
2 foo
3 bar
1 tux

$ echo "$lines" | uniq -c - | colrm 1 6
2 foo
3 bar
1 tux

# Case Insenstivie.
$ read -r -d '' lines << 'EOF'
> FoO
> fOO
> baR
> Bar
> bAr
> TUX
> EOF

$ echo "$lines" | uniq -ci - | cut -b 7- -
2 FoO
3 baR
1 TUX

$ echo "$lines" | uniq -u -
TUX
```

### Read In An Array

- Tags: \#cmdline \#shell \#bash \#arrays
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials-read-in-an-array)

``` shell-session
$ arr=()
$ while read -r line ; do arr+=("$line") ; done < /dev/stdin
$ echo "${#arr[*]}"
```

### Display an Element of an Array

- Tags: \#cmdline \#shell \#bash \#arrays
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials-display-the-third-element-of-an-array)

``` shell-session
mapfile -t countries
echo "${countries[3]}"
```

`-t` in `mapfile` removes the trailing delimiter so the array elements are “clean”.

### Count Elements in an Array

- Tags: \#cmdline \#shell \#bash \#arrays
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials-count-the-number-of-elements-in-an-array)

``` shell-session
mapfile -t countries
echo "${#countries[@]}"
```

### Slice An Array

- Tags: \#cmdline \#shell \#bash \#arrays
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials-slice-an-array)

Print the array with the syntax `${arr[*]:OFFSET:LENGTH}`.

``` shell-session
$ read -r -d '' countries << 'EOF'
> Namibia
> Nauru
> Nepal
> Netherlands
> NewZealand
> Nicaragua
> Niger
> Nigeria
> NorthKorea
> Norway
> EOF

$ echo "${arr[*]:3:5}"
Netherlands NewZealand Nicaragua Niger Nigeria NorthKorea Norway
```

Could read with `countries=($(cat))` too, but ShellSheck complains. Either use the `read` as above, or with `mapfile -t arr`.

Other options would be:

``` shell-session
paste -d ' ' -s | cut -d ' ' -f4-8 -
```

and:

``` shell-session
head -8 | tail -5 | paste -s -d ' ' -
```

### Concatenate Array With Itself

- Tags: \#cmdline \#shell \#bash \#arrays
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials-concatenate-an-array-with-itself)

``` shell-session
mapfile -t countries

countries+=("${countries[@]}" "${countries[@]}")

echo "${countries[*]}"
```

### grep A

- Tags: \#cmdline \#shell \#sed
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-in-linux-the-grep-command-4)

``` shell-session
$ grep -iw 'th\(e\|at\|en\|ose\)'
```

### grep B

- Tags: \#cmdline \#shell \#grep
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-in-linux-the-grep-command-5)

Works locally but not on HackerRank:

``` shell-session
$ grep '\(.\) \?\1'
```

This works locally and on HackerRank:

``` shell-session
$ grep '\(.\) \?\1'
```

### sed 3

- Tags: \#cmdline \#shell \#sed
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-in-linux-the-sed-command-3)

``` shell-session
$ sed 's/[Tt][Hh][Yy]/{&}/g'
```

### sed 4

- Tags: \#cmdline \#shell \#sed
- Links: [challenge](https://www.hackerrank.com/challenges/sed-command-4)

``` shell-session
$ sed 's/.* \([0-9]\{4\}\)/**** **** **** \1/g'
```

Or

``` shell-session
$ sed 's/[0-9]\+ /**** /g'
```

## Medium Challenges

### Paste 1

- Tags: \#cmdline \#shell \#paste
- Links: [challenge](https://www.hackerrank.com/challenges/paste-1)

``` shell-session
$ paste -s -d ';' -
```

### paste 2

- Tags: \#cmdline \#shell \#paste
- [challenge](https://www.hackerrank.com/challenges/paste-2)

``` shell-session
paste -d ';' - - -
```

### paste 3

- Tags: \#cmdline \#shell \#paste
- Links: [challenge](https://www.hackerrank.com/challenges/paste-3)

``` shell-session
$ paste -s -
```

### paste 4

- Tags: \#cmdline \#shell \#paste
- Links: [challenge](https://www.hackerrank.com/challenges/paste-4)

<!-- -->

    $ paste - - -

### sed 1

- Tags: \#cmdline \#shell \#sed
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-in-linux-the-sed-command-1)

``` shell-session
$ sed 's/\<the\>/this/'
```

### sed 2

- Tags: \#cmdline \#shell \#sed
- Links: [challenge](https://www.hackerrank.com/challenges/text-processing-in-linux-the-sed-command-2)

### grep challenges

- Tags: \#cmdline \#shell \#grep
- Links: [challenge1](https://www.hackerrank.com/challenges/text-processing-in-linux-the-grep-command-1), [challenge2](https://www.hackerrank.com/challenges/text-processing-in-linux-the-grep-command-2), [challenge3](https://www.hackerrank.com/challenges/text-processing-in-linux-the-grep-command-3)

``` shell-session
$ grep '\<the\>'

$ grep -i '\<the\>'

$ grep -iv '\<that\>'
```

### awk challenges

- Tags: \#cmdline \#shell \#awk
- Links: [challenge 1](https://www.hackerrank.com/challenges/awk-1), [challenge 2](https://www.hackerrank.com/challenges/awk-2), [challenge 3](https://www.hackerrank.com/challenges/awk-3), [challenge 4](https://www.hackerrank.com/challenges/awk-4)

Challenge 1:

``` shell-session
$ awk '{ if ($4 == "") print "Not all scores are available for " $1 }'
```

Challenge 2:

``` shell-session
awk '{
  answer[0] = "Fail";
  answer[1] = "Pass";
  print $1, ":", answer[$2 >= 50 && $3 >= 50 && $4 >= 50];
}'
```

Challenge 3:

``` shell-session
awk '{
  avg=($2 + $3 + $4) / 3
  if (avg >= 80)
    print $0 " : A";
  else if (avg >= 60)
    print $0 " : B";
  else
    print $0 " : FAIL";
}'
```

Challenge 4:

``` shell-session
awk 'ORS=NR % 2 ? ";" : "\n"'
```

### Filter an Array With Patterns

- Tags: \#cmdline \#shell \#bash \#arrays \#pattern-matching
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials-filter-an-array-with-patterns)

``` shell-session
while read -r line ; do
  if [[ ! "$line" =~ [Aa] ]]
  then
    echo "$line"
  fi
done
```

### Remove First Capital Letter From Each Array Element

- Tags: \#cmdline \#shell \#bash \#arrays \#pattern-matching
- Links: [challenge](https://www.hackerrank.com/challenges/bash-tutorials-remove-the-first-capital-letter-from-each-array-element)

``` shell-session
arr=()

while read -r line ; do
  arr+=("${line/[A-Z]/.}")
done

echo "${arr[*]}"
```

## Hard Challenges

### sed 5

- Tags: \#cmdline \#shell \#sed
- Links: [challenge](https://www.hackerrank.com/challenges/sed-command-5)

``` shell-session
sed 's/\([0-9]\+\) \([0-9]\+\) \([0-9]\+\) \([0-9]\+\)/\4 \3 \2 \1/'
```

NOTE: Backreferences in the search pattern mean they match the same chars, not the same general regex. That is, `(.)o(.)` matches “bob” or “bob”, for instance, but not “bop”. If `(.)` matched “x”, then `\1` in the search must also match an “x”. That is why we can’t do `s/\([0-9]\+\) \1 \1 \1`, because it would only match if all four fields of the number were the same thing, like “1234 1234 1234 1234”.

### Lonely Integer

- Tags: \#cmdline \#shell \#bash \#numbers
- Links: [challenge](https://www.hackerrank.com/challenges/lonely-integer-2)

Not very elegant, but makes use of arrays, which is what they ask for.

``` bash
#!/usr/bin/env bash

#
# This solution uses a histogram-like approach.
#

# Dummy-read, since we don't need the first argument they
# feed into the input.
read -r

# Read input numbers.
read -r -a nums

# An array to keep track of which numbers appeared how many times.
declare -A hist

for n in "${nums[@]}"
do
  if [[ -z "${hist[$n]}" ]]
  then
    # Use the number as index and increment that index and
    # initialize it to 1.
    hist[$n]=1
  else
    # Increment it each time that number appears.
    hist[$n]=$((${hist[$n]} + 1))
  fi
done

# Iterate over the indexes.
for idx in "${!hist[@]}"
do
  # If that number appeared only once...
  if (( hist[$idx] == 1 ))
  then
    # ...then print it and bail out.
    echo "$idx"
    break;
  fi
done
```

## Fractal Tree

- Tags: \#cmdline \#shell \#bash
- Links: [challenge](https://www.hackerrank.com/challenges/fractal-trees-all)

``` shell-session
#!/usr/bin/env bash

#
# Invoke it like this:
#
#   bash script.sh 5
#

declare -A grid
rows=63
cols=100

#
# Initialize the 63x100 grid with underscores.
#
init () {
  for (( row = 0; row < rows; ++row ))
  do
    for (( col = 0; col < cols; ++col ))
    do
      grid[$row,$col]=_
    done
  done
}

#
# Actually treeify the drawing.
#
treeify () {
  local count=$1
  local row=$2
  local col=$3
  local iteration=$4

  for (( i = 0; i < count; ++i ))
  do
    grid[$row,$col]=1
    (( row -= 1 ))
  done

  for (( i = 0; i < count; i++ ))
  do
    grid[$row,$((col - i - 1))]=1
    grid[$row,$((col + i + 1))]=1
    (( row -= 1 ))
  done

  if (( iteration > 1 ))
  then
    treeify $(( count >> 1 )) "$row" $(( col - count )) $(( iteration - 1 ))
    treeify $(( count >> 1 )) "$row" $(( col + count )) $(( iteration - 1 ))
  fi

}

#
# Simply output the grid, already treeified, to the screen.
#
display () {
  for (( row = 0 ; row < rows ; ++row ))
  do
    for (( col = 0 ; col < cols ; ++col ))
    do
      printf '%s' "${grid[$row,$col]}"
    done
    printf '\n'
  done
}

initial_count=16
initial_row=62
initial_col=49
iterations="${1:-5}"

if (( 1 > iterations || iterations > 5 ))
then
  printf '%s\n' 'Provide a number between 1 and 5, please.' 1>&2
else
  init
  treeify "$initial_count" "$initial_row" "$initial_col" "$iterations"
  display
fi
```

# The End
