---
description: Concepts, tips, ideas and examples on type casting with PostgreSQL.
---

# PostgreSQL Type Casting

PostgreSQL allows casting of types in a variety of ways.
Let's explore some examples that are useful from time to time.

## Timestamp to date

A blog `posts` table contains a `created_at` column which records the date and time when a post was originally saved.
But maybe we either need or want to only display the date disregarding the time part of the timestamp.

```{code} sql
:caption: Excerpt of the code to create a posts table
created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL
```

Then, we might run a query like this to retrieve the `created_at` and cast it to `DATE` (YYYY-MM-DD) ignoring the time part of the timestamp:

```{code} sql
SELECT
    C.name AS category
  , P.title
  , P.created_at::date
FROM categories AS C
  INNER JOIN posts AS P
  	ON C.category = P.category;
```

| Category      | Title                      | Created At   |
|---------------|----------------------------|--------------|
| hacker        | How To Become A Hacker     | 2001-01-01   |
| jedi          | The Ways Of The Force      | 9078-03-02   |

:::{note}
I have the reference for How To Become A Hacker by Eric Steven Raymond.
Worth reading!

https://www.catb.org/~esr/faqs/hacker-howto.html
:::
