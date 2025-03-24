# Basic SQL

**NOTE**: Assume these examples are run on PostgreSQL >= 13 at least.
As of 2022, I'm running these on Arch Linux with PostgreSQL 14.

Sometimes I do `\x` to turn on extended display in `psql` prompt.

## Adults Only

- [Adults Only Codewars SQL Challenge](https://www.codewars.com/kata/590a95eede09f87472000213/train/sql)

```sql
SELECT
    name
  , age
FROM users
WHERE age >= 18;
```

## Raise to the Power

- [Raise to the Power Codewars SQL Challenge](https://www.codewars.com/kata/594a8f653b5b4e8f3d000035/train/sql)
- [PostgreSQL Math Functions Docs](https://www.postgresql.org/docs/14/functions-math.html)

```sql
SELECT
  POWER(number1, number2) AS result
FROM decimals;
```

Looks like we can also use `POW(b, e)`.

## Calculating Batting Average

- [Calculating Batting Average Codewars SQL Challenge](https://www.codewars.com/kata/5994dafcbddc2f116d000024/train/sql)

```sql
SELECT
    player_name
  , games
  , ROUND(
      hits::NUMERIC / at_bats::NUMERIC),
      3
    )::VARCHAR(8) AS batting_average
FROM yankees
WHERE at_bats >= 100
ORDER BY batting_average DESC;
```

We can use `<value>::<type>` to *cast* from one type to another.
For example, `1::VARCHAR(4)` turns the 

ROUND():

```text
SELECT ROUND(1::NUMERIC, 2) AS num;
num | 1.00

SELECT ROUND(1.435::NUMERIC, 2) AS num;
num | 1.44

SELECT ROUND(1.7545::NUMERIC, 3) AS num;
num | 1.755
```

Division:

```text
SELECT (10 / 3) as num;
num | 3

SELECT (10::NUMERIC / 3::NUMERIC) as num;
num | 3.3333333333333333

```

`10 / 3` does INTEGER division.
To make it do fractional division, we must make the expression decimal/fractional somehow.
Technically, one value being `NUMERIC` is enough to make the whole expression `NUMERIC` (instead of doing integer division).

As a side note, Ruby (and some other languages) accept the same “trick”.
One value being fractional makes the entire expression fractional:

```irb
$ pry --simple-prompt
>> 10 / 3
=> 3

>> 10.0 / 3
=> 3.3333333333333335
```

## SQL with Pokemon: Damage Multipliers

- [SQL with Pokemon: Damage Multipliers Codewars SQL Challenge](https://www.codewars.com/kata/5ab828bcedbcfc65ea000099/train/sql)

```sql
SELECT
    pokemon_name
  , element
  , (str * multiplier) as modifiedStrength
FROM pokemon
JOIN multipliers
ON element_id = multipliers.id
WHERE str * multiplier >= 40
ORDER BY modifiedStrength DESC;
```

