---
description: In this post we learn how to Dockerise a simple Node.js application.
---

# Tutorial Docker Hello World Node.js App 1

## Introduction

This time we’ll write a hello world app, but using Node.js.

## The hello node.js application

Suppose this node.js application that prints a hello message to the
user name provided as an argument to the program.

```javascript
/**
 * Alias `console.log` to make it shorter to use. Why not‽
 *
 * @type {Console["log"]} log
 */
const log = console.log.bind(console);

/**
 * Returns a hello message to a given person's name.
 *
 * @param {string} name The name of the user for the hello message.
 * @returns {string}
 */
function getHello(name) {
  return `Hello, ${name}!`;
}

/**
 * Returns the actual parameters passed to the node process.
 *
 * Node's `process.argv` returns the node executable and the script
 * being run as the first two values. We want to skip those and
 * return only the params actually provided on the command line.
 *
 * @param {NodeJS.Process["argv"]} argv
 * @returns {Array<string>}
 */
function getParams(argv) {
  return argv.slice(2);
}

/**
 * Logs a hello message personalized to the given user's name.
 *
 * @param {name} string
 */
function sayHello(name) {
  log(getHello(name));
}

/**
 * Boot the program.
 */
(function main() {
  const params = getParams(process.argv);

  sayHello(params[0]);
})();
```

:::{note}
We are not really doing any error handling to keep the code shorter and focus on running it on Docker.
:::

Let’s first run the application on our host, local system. We need to provide a username as a parameter:

```
$ node ./src/app.js Yoda
Hello, Yoda!

$ node ./src/app.js 'Aayla Secura'
Hello, Aayla Secura!
```

## Create Dockerfile and build the image

Let’s create a `Dockerfile`:

```yaml
FROM node:latest

WORKDIR /myapp

COPY ./src /myapp/src

ENTRYPOINT ["node", "./src/app.js"]
```

This time, instead of the `CMD` instruction, we used `ENTRYPOINT` instruction.
This is necessary to allow us to run the container as an executable, which in turn allows it to correctly take command line arguments (which we’ll need to pass the user name).

Build the image:

```shell-session
$ docker build --tag nodejs-v1:latest .

λ docker image ls
REPOSITORY       TAG       IMAGE ID       CREATED              SIZE
node-v1          latest    d91bfe535d3b   About a minute ago   1.11GB
```

## Run the image as a container

We are finally able to run the image as a container, including providing the user name as a command line argument:

```shell-session
$ docker run --rm node-v1:latest Yoda
Hello, Yoda!

$ docker run --rm node-v1:latest "Aayla Secura"
Hello, Aayla Secura!
```

## References

- [Node.js image on Docker Hub](https://hub.docker.com/_/node)
- [ENTRYPOINT docs for Dockerfile](https://docs.docker.com/reference/dockerfile/#entrypoint)
- [CMD docs for Dockerfile](https://docs.docker.com/reference/dockerfile/#cmd)

