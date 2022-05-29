# Iterators

**INFO**: This topic starts at [32:06 in the video](https://youtu.be/wD5WGkOEJRs?t=1758).

There is actually a property on the Symbol type called “iterator” that contains the unique instance representing the iterator name, so that now if you wish to create an iterator or iterable object, we abide by this interface:

Iterable Objects:

1.  If it has a `Symbol.iterator` implementation method;
2.  And that method returns an object that obeys the iterator protocol      
    semantics;
    1.  at minimum, it has a `next()` method that returns a value/done object;
3.  Can thus be used in a variety of language constructors, such as the  
    `for-of` statement;
    1.  `for-of` will ask the `Symbol.iterator` to provide values.

Iterable and Iterator Interfaces:

```ts
interface Iterable<T> {
  // <1>
  [Symbol.iterator](): Iterator<T>;
}

interface Iterator<T> {
  // <2>
  next(value?: unknown): IteratorResult<T>;
  return?(value?: unknown): IteratorResult<T>;
  throw?(e?: unknown): IteratorResult<T>;
}
```

1.  We are taking the value of `Symbol.iterator` and using that as the name of
    the key for that particular method property.

2.  The only required method is `next()`, which returns an `IteratorResult`
    which is basically a named tuple of `value` and `done`.

## Iterator Example

```ts title="iterable/iterator example definition and usage"
--8<-- "src/typescript/ted-neward-advanced-typescript/e12-iterator.ts"
```

An *iterable* knows how to create an *iterator*. We don't actually need the `implements Iterable<Person>` because, again, TypeScript is all about structural types (not nominal/nominative types). We leave it there because we believe it improves understanding of what is going on and also to let the compiler know that I am trying to implement the iterator and makes sure I don't so something stupid.

Structural typing in this case means that I long as we have the method `[Symbol.iterator](): ...` this can be used anywhere an iterator is expected.


## References

- [Iteration Protocols at MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Iteration_protocols)
