---
description: Let's take a look at some useful psql cli settings and ideas which turn out to be useful when working with the sql prompt.
---

# PSQL CLI (PostgreSQL Command Line Interface)

## Setting the Prompt

We can login into Postgres using the psql cli using a shell command similar to this:

```
$ psql -h somehost -U user -d my_proj_db_devel -W
Password:
psql (15.3, server 14.8 (Debian 14.8-1.pgdg120+1))
Type "help" for help.

my_proj_db_devel=#
```

The, `my_proj_db_devel=#' is the prompt shown.
Sometimes, though, the database name is too long, causing the prompt to end up far to the right leaving not so much room for typing a command, or some other thing one might not like about it, like the looks, etc.

Let's make our psql prompt show `SQL> ` instead:

```text
my_proj_db_devel=# \set PROMPT1 'SQL> '

SQL> SELECT ROUND(3.14159, 2) AS my_pi;
 my_pi 
-------
  3.14
(1 row)

SQL>
```

On occasion, it looks cleaner and more pleasant to look at :)

## Visually display null values

Sometimes, for debugging purposes, show visual representation of `null` values instead of just seeing an empty cell in the results.

```text
SQL> SELECT col_a, col_b
FROM tbl_a LEFT OUTER JOIN tbl_b
ON col_a = col_b;
 col_a | col_b 
-------+-------
   102 |   102
   104 |   104
   106 |   106
   107 |
(4 rows)
```

Note the last cell, to the right of 107 simply shows nothing at all.
Is that an empty string or really null?
Not sure...
Well, we can instruct psql to show a specific string for `null` values:


```text
SQL> \pset null '<null>'
Null display is "<null>".

SQL> SELECT col_a, col_b
FROM tbl_a LEFT OUTER JOIN tbl_b
ON col_a = col_b;

 col_a | col_b 
-------+-------
   102 |   102
   104 |   104
   106 |   106
   107 | <null>
(4 rows)
```

Now it shows `<null>` which may help in some situations.

To _unset_, make it an empty string so nothing is shown.

```text
SQL> \pset null ''
```

Note that we must use single quotes.
Double quotes mean something else:

```text
SQL> \pset null ""
Null display is """".

SQL> SELECT col_a, col_b
FROM tbl_a LEFT OUTER JOIN tbl_b
ON col_a = col_b;

 col_a | col_b 
-------+-------
   102 |   102
   104 |   104
   106 |   106
   107 |    ""
(4 rows)
```

Note it now misleadingly shows `null` as an empty string `""`.
Probably not what we wanted.

Could also use a more fancy _empty set_ unicode character 0x2205 ∅:

```text
SQL> \pset null ∅ 
Null display is "∅".

SQL> SELECT col_a, col_b
FROM tbl_a LEFT OUTER JOIN tbl_b
ON col_a = col_b;

 col_a | col_b 
-------+-------
   102 |   102
   104 |   104
   106 |   106
   107 |     ∅
(4 rows)
```

```{note} Unicode Fonts
Your system must have unicode fonts installed for the “∅” (or other unicode chars) to be displayed properly.

Check the [Arch Wiki page on fonts](https://wiki.archlinux.org/title/Fonts) for more info on fonts and fonts that support Unicode. That page is useful even if you don't run Arch Linux or Linux.
```

## Visually display empty string

Null was covered above.
What about displaying empty strings and space-only strings?

First, let's create a test database and table with sample data:

```sql
CREATE DATABASE blog WITH
    ENCODING='UTF-8'
    OWNER=devel
    LC_CTYPE='en_US.UTF-8'
    LC_COLLATE='en_US.UTF-8'
    TEMPLATE=template0
    CONNECTION LIMIT=3;

-- \c blog

CREATE TABLE posts (
    id NUMERIC(3,0) PRIMARY KEY
  , title VARCHAR(128)
  , intro VARCHAR(254)
);

INSERT INTO posts (
    id
  , title
  , intro
) VALUES
  (1, 'Post 1', 'foo')
, (2, 'Post 2', ' ')
, (3, 'Post 3', '')
, (4, 'Post 4', NULL);
```

Note how the `intro` field was a non-empty string for post 1, then an empty string for post 2, a string consisting of a single space for post 3, and finally, `NULL` for post 4.

This is how it shows on defaults setting for psql:

```text
SQL> SELECT id, title, intro FROM posts;
 id | title  | intro 
----+--------+-------
  1 | Post 1 | foo
  2 | Post 2 |
  3 | Post 3 |
  4 | Post 4 |
(4 rows)

SQL> SELECT intro FROM posts;
 intro 
-------
 foo



(4 rows)
```

But we can concatenate `intro` with surrounding double quotes to help us visualize the string values and differentiate empty string from space-only strings:

```text
SQL> \pset null '∅'
Null display is "∅".

SQL> SELECT
    id
  , title
  , '"' || intro || '"' AS intro
FROM posts;
 id | title  | intro 
----+--------+-------
  1 | Post 1 | "foo"
  2 | Post 2 | " "
  3 | Post 3 | ""
  4 | Post 4 | ∅
(4 rows)
```

Or by creating a small helper function `VGDB` (visual debug):

```sql
CREATE FUNCTION VDBG(str VARCHAR) RETURNS VARCHAR
    LANGUAGE SQL
    IMMUTABLE
    RETURNS NULL ON NULL INPUT
    RETURN '"' || str || '"';
```

Then in psql:

```text
SQL> \pset null '∅'
Null display is "∅".

SQL> SELECT VDBG(intro) AS intro FROM posts;
 intro 
-------
 "foo"
 " "
 ""
 ∅
(4 rows)

SQL> SELECT id, title, VDBG(intro) AS intro FROM posts;
 id | title  | intro 
----+--------+-------
  1 | Post 1 | "foo"
  2 | Post 2 | " "
  3 | Post 3 | ""
  4 | Post 4 | ∅
(4 rows)
```

```{note}
In order to work, the `VGDB` function has to be run in `psql`, not in PG Admin or some other GUI tool.
I'm still investigating on this.
```
