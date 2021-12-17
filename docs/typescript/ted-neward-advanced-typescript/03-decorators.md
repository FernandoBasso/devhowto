# Decorators

**INFO**: This topic starts at [12:47 in the video](https://youtu.be/wD5WGkOEJRs?t=768).

!!! warn

    As of Dec 2021, the
    [decorators proposal](https://github.com/tc39/proposal-decorators)
    is in stage 2. Still,
    some projects
    (like [Angular](https://angular.io/api/core#decorators))
    have been using them for a long time.

Decorators allows defining metadata and acting on it. They are a special kind
of declaration that can be attached to a class, declaration, method, accessor,
property, or parameter.

It allows the attaching of metadata and runtime manipulation of language
constructs.

It uses the syntax `@expr`, where `expr` must evaluate to a function that will
be called at runtime with information about the decorated declaration.

!!! info

    When this video was recorded (at the time, v3.4 was the latest TypeScript
    version), the TypeScript spec had a “TODO” and decorators have not been
    documented. Also, the docs site showed one version of TypeScript, while
    the spec showed a much older version.

    At the time, there was an Github issue complaining about the spec not
    being updated for two years, and MS/TS folks told people to use the
    Handbook.  Except the hand book was lacking many TypeScript features.

    Then, Ted emphasized very much the importance of reading release notes.
    Many of the features had not been documented in the spec or in the docs
    site, but were documented in the notes for each release.

    Nowadays (2022) TypeScript docs have improved a lot and the Handbook is
    awesome. Still, from my personal experience, the release notes are still
    very relevant and I greatly recommend studying them very carefully.

> Decorators are functions run at the intersection of compile time/run time
> (hmm... not sure...).

Decorators are straight up functions. The use of it with `@` on some targets
makes it a decorator, but the function definitions (those that will be used as
decorators) themselves are normal functions.

## Simple Example

In this example, we have a class decorator.

```ts
function decorate(target: unknown) {
  log('Do something with ‘target’:', target);
}

@decorate
class Foo {}
```

Note we don't even do a `new Foo()`. And yet, we get this output:

```text
$ npx ts-node foo.ts 
Do something with ‘target’: [class Foo]
```

Te decorator fires only once when the class is being defined, not when we
use it, and it receives a reference to the target (the class in this case)
in order to be able to do stuff.

!!! info

    Decorators allows for very powerful features. In many respects, decorators
    are very close to being a full-fledged set of AOP (Aspect Oriented
    Programming). JavaScript has always had this ability to reach in and muck
    with our notion of a class in runtime.

    Fundamentally, this is referred to as Meta Object Programming and Meta
    Object Protocol (MOP) is the actual formal name for it, which was an idea
    introduced about two decades ago.

    Ironically, when
    [Gregor Kiczales](https://en.wikipedia.org/wiki/Gregor_Kiczales)
    sat down to create the language that would later be known as AspectJ — which
    is probably the best example of an Aspect Oriented Programming — he
    specifically wanted to create a constrained subset of Meta Object Protocol.

    We are flertting with these two-decade-old ideas. It is interesting to take
    a look at the early AOP docs, specifically around the Aspect J language. By
    the way, what Spring does at runtime with aspects is not really the same
    thing.  That is more of a method call interception thing which has been
    around even longer.  Yet, it can be done with decorators as well.

    That is the space your head wants to be when you start thinking about
    decorators.

## Class Decorators

* Applied to the constructor of the class;
* Can be used to observe, modify, or replace a class definition;
* Called at runtime, with the constructor of the decorated class as its only
  argument;
* Returning a value replaces the class declaration with the provided constructor
* function.

With *replace* we start to get into the MOP bits. You could keep the class
definition tucked away somewhere and had back proxies

```ts title="sealed decorator example"
--8<-- "src/typescript/ted-neward-advanced-typescript/e07-class-decorator.ts"
```

1. We define a function that takes a constructor function (ES6 class) and runs
   `Object.seal` on it so no further extensions to it is possible.

2. Defines a class with a property and a method and decorate it with `sealed`!

3. Defines an interface with the exact same name of the class to allow the
   addition of one more method.

4. Add a new method to `Greeter.prototype`. Seems OK but it will fail at
   runtime. Remember that we decorated this class with `sealed`. No one can
   mess with our implementation! We rule this class with an iron hand.

If we remove the `sealed` decorator, things work fine.

