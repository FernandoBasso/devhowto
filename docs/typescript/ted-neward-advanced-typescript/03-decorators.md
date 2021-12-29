# Decorators

**INFO**: This topic starts at [12:47 in the video](https://youtu.be/wD5WGkOEJRs?t=768).

!!! warn

    As of Dec 2021, the
    [decorators proposal](https://github.com/tc39/proposal-decorators)
    is in stage 2. Still,
    some projects
    (like [Angular](https://angular.io/api/core#decorators))
    have been using them for a long time.

## Intro

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

!!! info

    Using this is a way of making the class “final”, or as the Java spec calls
    it, “effectively final”.

## Method Decorators

* Applied to the Property Descriptor for the method;
* Can be used to observe, modify, or replace a method definition;
* Called as a function at runtime, with three arguments:
    * Either the constructor of class for a static member, or the prototype
      of the class for an instance member;
    * Member name;
    * Member Property Descriptor;
* If a value is returns it will be used as the Property Descriptor for the
  method.

```ts title="method decorator example"
--8<-- "src/typescript/ted-neward-advanced-typescript/e08-method-decorator.ts"
```

The example above uses a *decorator factory*, which is simply a function that
returns a decorator functions. The decorator factory takes a parameter, and
because of closures in ECMAScript, that parameter is available in the returned
decorator function. Every time a decorator needs parameters, a decorator
factory will be used.

Class decorators run only once when the class is defined (when parsing the
source code). Method decorators run every time a method is invoked (as do
accessor decorators).

!!! info

    Class instance methods are attached to the prototype of the object and are
    not enumerable. `Object.keys` will not retrieve a class's instance method,
    and `Object.getOwnPropertyNames` or `Object.getOwnPropertySymbols` will
    retrieve the method properties even if they are non-enumerable. Not sure
    about the use of the decorator `@enumerable(false)` in the `greet` method
    or how to make it not show up.

    The `PropertyDescriptor` is a formal object described in the ECMAScript
    spec that describes a property of an object.

    These are all related topics:

    - [Enumerability and Ownership at MDN](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Enumerability_and_ownership_of_properties)
    - [Enumerability of Properties in the Exploring JS book](https://exploringjs.com/deep-js/ch_enumerability.html)
    - [PropertyDescriptor](https://tc39.es/ecma262/#sec-property-descriptor-specification-type)
    - [MDN getOwnPropertyDescriptor](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/getOwnPropertyDescriptor)
    - [MDN defineProperty](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Object/defineProperty)


## Accessor Decorators

* Applied to the Property Descriptor for the accessor;
* Can be used to observe, modify, or replace an accessor definition;
* Called as a function at runtime, with three arguments:
    * Either the constructor of class for a static member, or the prototype
      of the class for an instance member;
    * Member name;
    * Member Property Descriptor;
* If a value is returns it will be used as the Property Descriptor for the
  member.

```ts title="method decorator example"
--8<-- "src/typescript/ted-neward-advanced-typescript/e09-accessor-decorator.ts"
```

1. We replace the accessor with our own function, which logs (traces) and then
   calls the original getter with `getter.call(this)`. Arrow functions would
   not work here because we need the correct value of `this`.

The accessor is the *getter* or *setter* that go along with the field. They
are known as *accessor properties*.

> This is Aspect Oriented Programming at its finest.
> 
> — Ted Neward

Every time we access `x` or `y`, the `trace` decorator, because it is an
accessor decorator, will be fired (contrary to class decorators that run only
once when the class is defined).

What we did here is what the AOP people referred to as *wrappers*.

## Property Decorators

1. Declared just before a property declaration;
2. Call as a function at run time, with the following two arguments:
y
3. Due to limitations in ES Spec and TS, a property decorator can only be used
   to observe that a property of a specific name has been declared for a class.

```ts title="property decorator example"
--8<-- "/home/fernando/work/src/devhowto/src/typescript/ted-neward-advanced-typescript/e10-property-decorator.ts"
```

The property decorator is run only once when the property is defined (the source
is parsed). It behaves like a class decorator in this regard (contrary to
method and accessor decorators that fire every time a method or accessor
is executed).

## Parameter Decorators

1. Declared just before a parameter declaration;
2. Applied to the function for a class constructor or method declaration;
3. Called as a function at run time, with the following three arguments:
    1. Either the constructor of class for a static member, or the prototype
      of the class for an instance member;
    2. Member name;
    3. Ordinal index of the parameter in the function's parameter list;
4. Can only be used to observed that a parameter has been declared on a method;
5. Return value of the parameter decorator is ignored.

## Order of Evaluation

Order of evaluation is not important until it becomes important in a given
situation 🤣️. Check
[Decorator Evaluation](https://www.typescriptlang.org/docs/handbook/decorators.html#decorator-evaluation)

## Decorator Composition

1.  Multiple decorators on a given declaration compose (a chain of calls that
    resolve all at once);
2.  Very specific order;
    1. Expressions for each decorator are evaluated to-to-bottom;
    2. Results are then called as functions from top-top-bottom;
3.  Very similar to function composition in functional languages;

```ts title="decorator composition example"
--8<-- "src/typescript/ted-neward-advanced-typescript/e11-decorator-composition.ts"
```

This is the classic "f of g" function composition scenario. But with decorators
🚀️.

More often than not decorators should be written so that the order of evaluation should not matter — just work with what you've got and don't make
any assumptions about anything that is going on around you — but sometimes
decorators may want to work together to create some higher order functionality
and knowing that they will compose is important, order may matter and some
assumptions about the outside world may be unavoidable.
