# Intro

My notes on the amazing
[Busy TypeScript Developer’s Guide to Advanced TypeScript by Ted Neward (youtube)](https://youtu.be/wD5WGkOEJRs).

Some examples may have been adapted with newer TypeScript features, or
made a little more realistic since I'm transcribing them from the talk
slides to the webpages, which makes it more appropriate to have
lengthier code with extra explanations or annotations.

## Some Interesting Comments From Ted Neward

> TypeScript has so many interesting that are just not present in any other
> language that I've seen in the traditional static, object-oriented space.

## Strict TypeScript Settings

This is not something recommended or mentioned in the video (that I
recall), but which is a good idea to apply when studying or starting new
projects.

Start your coding and studies with a setting like this in
`tsconfig.json`:

```
{
  "compilerOptions": {
    /* Set the JavaScript language version for emitted JavaScript and include
     * compatible library declarations. */
    "target": "ES2017",

    /* Specify what module code is generated. */
    "module": "commonjs",

    /* Emit additional JavaScript to ease support for importing CommonJS
     * modules.  This enables `allowSyntheticDefaultImports` for type
     * compatibility. */
    "esModuleInterop": true,

    /* Ensure that casing is correct in imports. */
    "forceConsistentCasingInFileNames": true,

    /* Enable all strict type-checking options. */
    "strict": true,

    /* Skip type checking all .d.ts files. */
    "skipLibCheck": true,
  }
}
```

!!! info

    This is [JSON5](https://json5.org/), a superset of JSON that, among other
    important things, allows the use of comments.

## Outline of Topics

In the video:

* [00:34](https://youtu.be/wD5WGkOEJRs?t=34) Type Compatibility
    * [01:03](https://youtu.be/wD5WGkOEJRs?t=63) Structural Subtyping
    * [03:03](https://youtu.be/wD5WGkOEJRs?t=183) Type Assertions
    * [04:31](https://youtu.be/wD5WGkOEJRs?t=271) Type Guards
    * [05:00](https://youtu.be/wD5WGkOEJRs?t=300) typeof Type Guards
* [06:08](https://youtu.be/wD5WGkOEJRs?t=368) Simple and Compound Types
    * [06:11](https://youtu.be/wD5WGkOEJRs?t=371) Arrays
    * [06:15](https://youtu.be/wD5WGkOEJRs?t=376) Arrays and Tuples
    * [06:29](https://youtu.be/wD5WGkOEJRs?t=389) Union Types
    * [06:55](https://youtu.be/wD5WGkOEJRs?t=415) Intersection Types
    * [09:22](https://youtu.be/wD5WGkOEJRs?t=562) Tuples
    * [10:28](https://youtu.be/wD5WGkOEJRs?t=570) Destructuring
    * [12:12](https://youtu.be/wD5WGkOEJRs?t=732) Enums
* [12:53](https://youtu.be/wD5WGkOEJRs?t=773) Decorators
    * [16:16](https://youtu.be/wD5WGkOEJRs?t=966) Simple Example
    * [19:39](https://youtu.be/wD5WGkOEJRs?t=1171) Class Decorator Example
    * [20:47](https://youtu.be/wD5WGkOEJRs?t=1247) Method Decorator Example
    * [22:56](https://youtu.be/wD5WGkOEJRs?t=1249) Accessor Decorators
    * [24:50](https://youtu.be/wD5WGkOEJRs?t=1490) Property Decorators
    * [25:45](https://youtu.be/wD5WGkOEJRs?t=1490) Parameter Decorators
    * [25:58](https://youtu.be/wD5WGkOEJRs?t=1558) Order of Evaluation
    * [27:03](https://youtu.be/wD5WGkOEJRs?t=1623) Decorator Factories
    * [27:12](https://youtu.be/wD5WGkOEJRs?t=1632) Decorator Composition
* [29:18](https://youtu.be/wD5WGkOEJRs?t=1758) Symbols
    * [31:28](https://youtu.be/wD5WGkOEJRs?t=1888) Usage
* [32:06](https://youtu.be/wD5WGkOEJRs?t=1926) Iterators
    * [32:10](https://youtu.be/wD5WGkOEJRs?t=1930) Iterable Objects
    * [32:58](https://youtu.be/wD5WGkOEJRs?t=1981) Example Iterable/Iterator
* [34:43](https://youtu.be/wD5WGkOEJRs?t=2083) Generators
* [40:51](https://youtu.be/wD5WGkOEJRs?t=2451) Generics
    * [49:47](https://youtu.be/wD5WGkOEJRs?t=2987) Generic Interfaces
    * [51:15](https://youtu.be/wD5WGkOEJRs?t=2987) Generic Classes
    * [52:17](https://youtu.be/wD5WGkOEJRs?t=3137) Generic Constraints
    * [54:09](https://youtu.be/wD5WGkOEJRs?t=3249) Generic Parameter Defaults
* [56:49](https://youtu.be/wD5WGkOEJRs?t=3411) Conditional Types


Ted also mentions this post:

https://www.freecodecamp.org/news/typescript-curry-ramda-types-f747e99744ab/

[My comment on the video](https://www.youtube.com/watch?v=wD5WGkOEJRs&lc=UgxhqwyNE3_jA1QOFtN4AaABAg)
