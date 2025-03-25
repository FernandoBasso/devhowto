---
description: Some examples and ideas on how to apply aggregate functions and other operations on column data.
---

# SQL Operations on Column Data

Sometimes we want to select a column, but then perform some transformation on the data.
Maybe we want to format a timestemp in a certain way, round a decimal value, truncate a string, concatenate the data in with some other data or column, etc.

This page will list some examples, many of which have helped me at work from time to time.

## Intro to SQL aggregate functions

The basic aggregate functions to operate on column data are `COUNT()`, `SUM()`, `MIN()`, `MAX()` and `AVG()`.
And of course, there are others.
For example, check these pieces of documentation:

- [Aggregate functions on PostgreSQL docs](https://www.postgresql.org/docs/current/functions-aggregate.html)
- [Aggregate functions on MariaDB docs](https://www.postgresql.org/docs/current/functions-aggregate.html)

The use is something like this:

```{code} sql
SELECT AVG(grade) AS avg_grade
FROM exams;
```

The result would be something like:

```{code} text
avg_grade
       78
```

## Sum and division example

```{code} sql
---
SELECT 
    SUM(balance) AS total_in_cents
  , SUM(balance) / 100.0 AS total_in_dollars
FROM accounts
WHERE ref IN (
    'ref-1'
  , 'ref-2'
  , '...'
  , 'ref-n'
);
```

And it should return something like this:

```{code} text
total_in_cents, total_in_dollars
        254294,          2542.94
```
