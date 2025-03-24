---
description: Notes on designing, managing and using databases and SQL.
---

# Intro to Databases and SQL

SQL stands for Structured Query Language.
No mater which (relational) database vendor being used (PostgreSQL, MariaDB, etc.), the language to work with the data and other aspects is the SQL language.
SQL does much more than just *query* data, though.

It is common to pronounce SQL as three letters S Q L (and not as the word “sequel”), which means we say “*an* SQL statement” rather than “*a* SQL (sequel) statement”.

Here you'll find some notes, concepts, ideas, examples and guides on how to do work with:

- Data Definition Language (DDL).
- Data Manipulation Language (DML).
- Data Control Language (DCL). 
- A few other types of queries.

All of the above are different kinds of SQL statements, but all SQL statements nonetheless.
DDL is about the structure of the database structure, while DML operates on the data.

I use mostly PostgreSQL and MariaDB, so expect most examples to work on those.

SQL is a standardized language (even though each vendor adds their own features, commands and other facilities) on top of the standard language.
The standard is **NOT** free (like HTML, CSS or ECMAScript, among others).
One has to purchase it on [their website](https://www.iso.org/standard/63555.html).
Thankfully, we can be learn for free on the web by reading DB vendors documentation and doing online challenges.
Same resources:

- [PostgreSQL docs](https://www.postgresql.org/docs/current/index.html).
- [MariaDB docs](https://mariadb.com/kb/en/).
- [Codewars SQL for Beginners](https://www.codewars.com/collections/sql-for-beginners).
- [HackerRank SQL challenges](https://www.hackerrank.com/domains/sql).


## Basics

SQL statements are composed of *keywords* (defined in the standard), *identifiers* (names of tables, columns, views, etc., defined by the DB user or admin), and *constants*.

```sql
SELECT
    id
  , name
  , skill
  , power
FROM jedis
WHERE power >= 78
;
```

We wrote the keywords in UPPERCASE (common practice).
The identifiers are `jedis` (table name) and `id`, `name`, `skill` and `power` (column names).
78 is a numeric constant.

`>=` is an operator, which is a special kind of keyword.

`SELECT`, `FROM` and `WHERE` (among many others) are also *clauses*. We say “the WHERE clause”, or “the SELECT clause”, etc.

## Data Definition Language

The most used DDL languages involve `CREATE`, `ALTER` and `DROP` clauses.

Let's create a new database in PostgreSQL:

```sql
CREATE DATABASE starwars_dev
    WITH
    OWNER = devel
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = 3
    IS_TEMPLATE = False;
```

And then create a table:

```sql
CREATE TABLE jedis
(
    id INTEGER NOT NULL PRIMARY KEY
  , name VARCHAR(64) NOT NULL
  , power SMALLINT NOT NULL DEFAULT 50
);
```

And alter `name` to be `VARCHAR(128)`:

```sql
ALTER TABLE jedis
  ALTER COLUMN name TYPE VARCHAR(128);
```

Make column `name` nullable:

```sql
ALTER TABLE jedis
  ALTER COLUMN name SET NOT NULL;
```

Make column name not nullable:

```sql
ALTER TABLE jedis
  ALTER COLUMN name DROP NOT NULL;
```

Remove a column:

```sql
ALTER TABLE jedis
  DROP COLUMN power;
```

## Data Manipulation Language

The most used DML language statements involve `INSERT`, `UPDATE` and `DELETE`.
