# HackerRank Easy SQL Challenges

## Revising The Select Query I

* [Revising the Select Query I :: HackerRank SQL Challenge](https://www.hackerrank.com/challenges/revising-the-select-query).

```sql
SELECT
  id
, name
, countrycode
, district
, population
FROM
  city
WHERE
  population >= 100000
AND
  countrycode = 'USA';
```

We can replace all column names with the star `*`, but it is more readable if all column names are explicitly stated in the query.

Also, we could use `LIKE` in place of `=` for this case: `... AND countrycode LIKE 'USA'`.

## Revising the Select Query II

* [Revising the Select Query II :: HackerRank SQL Challenge](https://www.hackerrank.com/challenges/revising-the-select-query-2).

```sql
SELECT
  name
FROM
  city
WHERE
  population >= 120000
    AND countrycode = 'USA';
```

## Select All

* [Select All :: HackerRank SQL Challenge](https://www.hackerrank.com/challenges/select-all-sql).

```sql
SELECT
  id
, name
, countrycode
, district
, population
FROM
  city;
```

Again, writing the column names explicitly makes it more self-documenting than simply using `*`.

## Select By ID

* [Select By ID :: HackerRank SQL Challenge](https://www.hackerrank.com/challenges/select-by-id).

```sql
SELECT
  id
, name
, countrycode
, district
, population
FROM
  city
WHERE
  id = 1661;
```

## Japanese Cities' Attributes

* [Japanese Cities' Attributes :: HackerRank SQL Challenge](https://www.hackerrank.com/challenges/japanese-cities-attributes).

```sql
SELECT
  id
, name
, countrycode
, district
, population
FROM
  city
WHERE
  countrycode = 'JPN';
```

## Weather Observation Station 1

* [Weather Observation Station 1 :: HackerRank SQL Challenge](https://www.hackerrank.com/challenges/weather-observation-station-1).

```sql
SELECT
    city
  , state
FROM station;
```

## Weather Observation Station 2

* [Weather Observation Station 2 :: HackerRank SQL Challenge](https://www.hackerrank.com/challenges/weather-observation-station-2).

```sql
SELECT
  ROUND(SUM(lat_n), 2) AS lat
, ROUND(SUM(long_w), 2) AS lon
FROM station;
```

We can `SUM` any numeric column, e.g.:

```sql
SELECT SUM(id) FROM users;
```

And also `ROUND(value, num_decimal_places)`, e.g.:

**psql session**

```text
mydb=# SELECT ROUND(3.141592653589793, 5);
  round
---------
 3.14159

mydb=# SELECT ROUND(3.14159, 2) AS PI;
  pi
------
 3.14
```

So we basically round the result of the sum and rename the output columns as `lat` and `lon`.

## Weather Observation Station 5

* [Weather Observation Station 5 :: HackerRank SQL Challenge](https://www.hackerrank.com/challenges/weather-observation-station-5)

```sql
(
  SELECT
      city
    , LENGTH(city) AS len
  FROM station
  ORDER BY len DESC, city ASC
  LIMIT 1
) UNION ALL (
  SELECT
      city
    , LENGTH(city) AS len
  FROM station
  ORDER BY len ASC, city ASC
  LIMIT 1
);
```

We basically have two queries.
One that selects the city with lengthier name (`ORDER BY len DESC`), and another that selects the city with the shortest name (`ORDER BY len ASC`).

We also sort by city name in ascending order so if multiple cities have the same max or min length, we choose the first one alphabetically.

For each query, we limit by 1.

Finally, the `UNION ALL` produces the final tabular structure with the result of the two _individual_ queries.

## Weather Station Observation 7

* [Weather Station Observation 7 :: HackerRank SQL Challenge](https://www.hackerrank.com/challenges/weather-observation-station-7)

### Solution 1 using ORs

Simply using a lot of ``OR`’s to match city names ending in vowels.

```sql
SELECT DISTINCT city
FROM station
WHERE city LIKE '%a'
OR city LIKE '%e'
OR city LIKE '%i'
OR city LIKE '%o'
OR city LIKE '%u';
```

:::{note}
Case sensitivity depends on a few things like collation and/or other configurations.
This solution worked on HackerRank so we are fine with it.
:::

### Solution 2 using REGEXP_LIKE

Very standard regex syntax.
Using “or” (`|`) with grouping and matching the “end of string” with `$`.

```sql
SELECT DISTINCT city
FROM station
WHERE REGEXP_LIKE(city, '(a|e|i|o|u)$')
```
