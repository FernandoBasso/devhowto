# Intro to The Command Line

```{figure} ../__assets/bash-help.png
:alt: bash help

Bash help
```

Command line tools have NOT faded out into the past. They have kept consistently evolving and being improved. They still do! A lot of GUI interfaces use command line tools behind the scenes.

There exists a specification to standardize how command line utilities should behave so that they work in a cross-platform, interoperable way.

GNU and BSD command line utilities generally try to follow the specs but add the so called *extensions* which add further capabilities to the tools, making writing scripts and programs easier and sometimes less verbose, but also reduce the portability. Some tools can be run in a more restrict way that disallow extensions. The docs for each tool should specify those things. Information about these things is also scattered across this website's notes and examples when they are deemed important and/or worthwhile.

Besides reading the specs, also take a look at the sidebar about reading and understanding man pages, info pages and help pages.

> [!NOTE]
> Assume all text and examples on this site is written considering GNU tools and the Bash shell unless otherwise noted.

## Single Unix Specification (SUS)

The latest spec is from 2024:

- [The Open Group Base Specifications Issue 8 (2024)](https://pubs.opengroup.org/onlinepubs/9799919799.2024edition/mindex.html)

Some definitions:

XBD
: Base Definitions

XSH
: System Interfaces and XBD Headers

XCU
: Shell and Utilities (Commands and Utilities)

There is a question about the [difference between SUS and Open Group](https://unix.stackexchange.com/questions/14368/difference-between-posix-single-unix-specification-and-open-group-base-specifi/14369).

## Yes, That Website Sucks

Yes, that website sucks. Not the contents of the website, but the way it works!

The whole thing is full of iframes. URLs don't change (only the iframes contents do) when we click on sidebar links which means it is impossible to share or bookmark different URLs do. HOWEVER, if we **open links on a new tab** then we get out of the iframe hell thing. So, open links on a new tab when you need the URL for that link.

## GNU Coreutils

> [!NOTE]
> The examples on this site assume GNU tools and GNU Coreutils. If you find something that doesn't work on your version/vendor of the tool, feel free to open a PR to this project proposing an alternative working solution.

It is worth taking a look at following resources:

- [GNU Coreutils Home Page](https://www.gnu.org/software/coreutils/)
- [GNU Coreutils FAQ](https://www.gnu.org/software/coreutils/faq/coreutils-faq.html)
- [GNU Coreutils Documentation](https://www.gnu.org/software/coreutils/manual/)
- [GNU Coreutils Decoded](http://www.maizure.org/projects/decoded-gnu-coreutils/)

There is also the mind-blowing, awesome [Decoded GNU Coreutils](http://www.maizure.org/projects/decoded-gnu-coreutils/) project by [MaiZure](http://www.maizure.org/projects/faq.html).

