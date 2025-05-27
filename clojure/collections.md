---
description: Notes and explanations on Clojure collections, including the access time for some of the operations we use the most.
---

# Clojure Collections

## count, linear or constant time?

When we use `(count coll)`, is it linear or constant time?

And of course, it depends on the collection type.
Some will require walking the nodes or elements, while some use an internal metadata field that gets updated as elements are added or removed, allowing the count to be retrieved at constant time.

We can use [counted?](https://clojuredocs.org/clojure.core/counted_q) that can be used to check whether the given collection implements `count` in constant time.
For clojure’s own persistent collections where `counted?` returns false, then the time complexity is likely to be linear.

There’s also some special handling of a mix of Java types, and the complexity there depends on the implementation of that Java type.

:::{tip} Constant time vs linear time
Remember that constant time is $O(1)$ and linear time is $O(n)$.
:::
