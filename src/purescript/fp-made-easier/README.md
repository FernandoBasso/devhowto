# Functional Programming Made Easier

The book was written with PureScript 0.14 in mind, but I'm studying it with as of May 2022 with PureScript 0.15.

- [PureScript v0.15.0 Released](https://discourse.purescript.org/t/purescript-v0-15-0-released/2989)
- [v0.15 migration guide](https://github.com/purescript/documentation/blob/master/migration-guides/0.15-Migration-Guide.md)

## Studying the book

Create directories like `ch01`, `ch02`, etc. and run `spago init` inside each directory. Make simple module names like `DataTypes1.purs` or `SumType.purs` with examples. Do NOT bother trying to keep them numbered with chapter, section, subsection, etc.

Sometimes, the books show code I don't yet know how to fully implement in this language, like `StringStats` with its `vowelCount` function in 3.1.3. The idea as that we go back and forth in the book as it makes sense. We should try our best to understand things at the moment we are studying them, but no learning is without gaps anyway. We MUST come back and fill the gaps, understand better and get new insights later on. As base knowledge helps to gain future knowledge, future knowledge also helps one to better re-learn things learned in the past. You look into past experiences with new eyes, new mindset, more context, etc.

When I studied music, books would say things like “do not move forward until you mastered this scaled 100%.” It is humanly impossible to try that kind of approach. We would be stuck forever practicing one thing only and never truly, really *master* it (achiever perfection). It is better to get going with something, then move forward, then come back and fill the gaps, improve, perfect.

**NORM**: If I fail to implement some example from the book because of lack of knowledge, add a comment AT THE TOP of the module with this content:

```
--
-- @TODO @FIXME, page <page number>
--
```

It is then easier later on to search for those and keep trying as we acquire further knolwedge.

## spago, purescript, purs-tidy

Install node and PureScript packages:

```shell-session
$ nvm install < .nvmrc
$ npm install
```

Then to open a REPL, build or run:

```shell-session
$ npx spago repl
$ npx spago build
$ npx spago run
```

## [n]vim, CoC

```shell-session
$ cd ch03
$ npm install --global purescript-language-server
```
