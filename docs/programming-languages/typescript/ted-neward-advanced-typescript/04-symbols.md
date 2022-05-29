# Symbols

**INFO**: This topic starts at [29:18 in the video](https://youtu.be/wD5WGkOEJRs?t=768).

Symbols allows us to define unique instances of names:

* Defined as part of ECMAScript, not TypeScript;
* Usually for use as unique names for properties/keys;
* Not for security purposes, but to preserve encapsulation/inheritance chains.

Suppose we write libraries, and stuff are evaluated at run time, and convention based, and if I create a class, and by convention we say it will be a factory
if it has a `create` method, that is cool and works until every other library
that I work with understands that convention and stays away from calling their
method `create`.

If I'm just depending on that _string_, anybody could be using that string and
we and up with the potential naming conflicts. Particularly in the ECMAScript
world, which is common to use mixins and merge objects together. If two objects
have a `create` method, which one wins when the objects are merged? It depends
on which one was the source, and which one was the destination, and that is assuming we didn't create a third object to copy them both over. At this point, all bets are off and it is anybody's guess.

For ECMAscript, they wanted to be able to have a series of names that were going to be guaranteed to be unique, that everybody could access. I don't want to have to type UUIDs as method names, but I want the runtime do to it for me, so when I pass a in a name of something, I'll get a UUID that one of us will ever see — it will be hidden behind this symbol instance. And then we can use that symbol for uniqueness.

## Symbol Usage

* Create a `Symbol` instance using a string name;
* Utilize that instance (instead of string) as key/name;
* If privacy/hiding is an issue, tuck the instance away somewhere inaccessible;
* Some well-known Symbols are accessible on `Symbol` itself (e.g. `[Symbol.iterator]`).

We use that symbol as the actual name for properties, methods, etc.

They are useful in a number of scenarios, such as iterators.

