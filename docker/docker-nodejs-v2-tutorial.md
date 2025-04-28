---
description: This post follows up on the previous tutorial to set up a more real-life Docker envirlment with Node.js
---

# Docker Node.js App for Local Development

## Introduction

When we are developing an application, we need some means to write code and have the application reload or recompile without us having to rebuild the image each time.
We need something more practical.
For that, we can use volumes so that the changes we do on our local machines are reflected inside the running container automatically.

To understand how we can achieve it, let’s write a Node.js application that logs some messages.
If we change the source code on our local files, the application inside the _running_ container will automatically rerun and execute the new, changed code.

For that, one of the things we need is a docker volume so we can sort of mount a local directory as if it is a disk inside the container.

And whatever programming language or framework we are using should also provide some means of detecting changed files and rerun when they do.
For Node.js, we can make use of [nodemon](https://github.com/remy/nodemon).

## The Node.js app

```javascript
/**
 * Alias `console.log` to make it shorter to use. Why not‽
 *
 * @type {Console["log"]} log
 */
const log = console.log.bind(console);

(function main() {
  log('Hello!');
})();
```

## package.json

Let’s add `nodemon` as a dev dependency, and it can always be latest version (for this very simple example) so we use `*` instead of a specific version.

```json
{
  "name": "nodejs-v2",
  "version": "0.0.1",
  "scripts": {
    "dev": "nodemon --quiet ./src/app.js"
  },
  "license": "ISC",
  "devDependencies": {
    "nodemon": "*"
  }
}
```

Install de dependencies and run the `dev` script:

```shell-session
$ npm install

$ npm run dev
Hello!
```

All good.

## Trying the reload in local

Without stopping the `dev` script (like by hitting kbd:[Ctrl+C]), suppose we update our `log` line in ``./src/app.js`’s main function:

**./src/app.js**

```diff
(function main() {
-  log('Hello!');
+  log('Hello, World!')
})();
```

The new output should now show something like this:

**Output**

```text
Hello, World!
```

Seems to be working, at least from our local filesystem.
We are ready to try our hand at another `Dockerfile`.

## Dockerfile

```yaml
FROM node:latest

WORKDIR /myapp

COPY ./src ./myapp/src

ENTRYPOINT ["npm", "run", "dev"]
```

Nothing new here.
We basically just run `npm run dev` from an `ENTRYPOINT` instruction.

## Build and run

Let’s build and run the image as a container:

```shell-session
$ docker build --tag nodejs-v2:latest

$ docker run nodejs-v2:latest
```

**Output**

```text
Hello, World!
```

If we now change `./src/app.js`, the changes will not be reflected at all inside the running container and `nodemon` will not be able to detect any changes.
The files we copied with the `COPY` instruction while building the image will have the contents they had at that moment.
The file system inside the running container has no visibility of our new, changed files.

We need to use a Docker volume so that the changes in our local filesystem are reflected inside the running container.

## Docker volumes

We don’t need change anything in `Dockerfile` and/or rebuild the image.
The only thing we need to have the local file system and the container to share files live is to use `--volume` (or `-v` for the short option) with the correct mount point values.

In our case, we want to mount the root directory of our project as `/myapp` inside the container, therefore, we can run `docker run` like this:

```shell-session
λ docker run --rm --volume ./:/myapp --name node_app nodejs-v2:latest

> nodejs-v2@0.0.1 dev
> nodemon --quiet ./src/app.js

Hello, World!
```

Note that because we now are using `nodemon` to run the app, the process lingers indefinitely, and the container keeps running until it is stopped on purpose (or if the process crashes and terminates due to some problem or failure).

Suppose we add another `log` line to `./src/app.js`:

**app.js with a new log line**

```diff
(function main() {
  log('Hello, World!');
+ log('It works! They said I was mad but it works!!');
})();
```

Then, in addition to the existing output lines, we should see two new lines:

**Output**

```text
Hello, World!
It works! They said I was mad but it works!!
```

## Stopping the container

Maybe due to the way `nodemon` works, hitting kbd:[Ctrl+C] three times displays the message “got 3 SIGTERM/SIGINTs, forcefully exiting” and returns the prompt to the user:

```text
$ docker run --rm --volume ./:/myapp --name node_app nodejs-v2:latest

> nodejs-v2@0.0.1 dev
> nodemon --quiet ./src/app.js

Hello, World!
It works! They said I was mad but it works!!
^C^C^C
got 3 SIGTERM/SIGINTs, forcefully exiting
```

Yet, the container is still running.
In situations like this we can stop the container with another docker command instead:

```bash
$ docker container stop node_app
```

## Files and permissions

If we run the container:

```bash
$ docker run --rm --volume ./:/myapp --name node_app nodejs-v2:latest
```

And shell into it, and create a file from _that_ shell running _inside_ the container, then the file belongs to the root user and the root group:

```bash
$ docker exec -it node_app /bin/bash
root@669d48bafe50:/myapp# 1> ./message.txt echo 'A test message.'
root@669d48bafe50:/myapp# ls -l
total 44
-rw-r--r--  1 node node    93 Sep 15 10:45 Dockerfile
-rw-r--r--  1 node node  5520 Sep 15 13:52 README.adoc
-rw-r--r--  1 root root    16 Sep 15 13:56 message.txt
drwxr-xr-x 32 node node  4096 Sep 14 13:56 node_modules
-rw-r--r--  1 node node 12298 Sep 14 13:56 package-lock.json
-rw-r--r--  1 node node   177 Sep 14 13:56 package.json
drwxr-xr-x  2 node node  4096 Sep 14 14:10 src
root@669d48bafe50:/myapp#
```

And if we now look from the host system shell, the file will be there as well, and also belonging to `root:root`.

Fortunately, `docker run` takes the `--user` option, in the format `--user user_id:group_id`, which we can dynamically set with the `id` command on many Unix systems.
For example, on my Arch Linux system, my user has the ID 1000 and my group id is also 1000:

```bash
$ id --user
1000

$ id --group
1000
```

So we could run a command similar to this one:

```bash
$ docker run \
    --rm \
    --user 1000:1000 \
    --volume ./:/myapp \
    --name node_app \
    nodejs-v2:latest
```

But on other machines or systems, the user and group ID could be different, so we are probably better off by using subshells to create the `<user_id>:<group_id>` value.
For instance:

```bash
$ echo "$(id --user):$(id --group)"
1000:1000
```

And than use that in our `docker run` command:

```bash
$ docker run \
    --rm \
    --user "$(id --user):$(id --group)" \
    --volume ./:/myapp \
    --name node_app \
    nodejs-v2:latest
```

A **very important thing to note** is that now the shell prompt inside the container is not showing as `#` (indicating the root user), but instead, it displays `$` (indicating a normal, non-root user).

If we now shell into the container, create a file and list its permissions, it should belong to the non-root user, but to the node user, in case of the image we are using:

```bash
$ docker exec -it node_app /bin/bash
node@3af191745741:/myapp$ 1> ./other-message echo 'Another message'
node@3af191745741:/myapp$ ls -l
total 44
-rw-r--r--  1 node node    93 Sep 15 10:45 Dockerfile
-rw-r--r--  1 node node  7674 Sep 15 14:27 README.adoc
drwxr-xr-x 32 node node  4096 Sep 14 13:56 node_modules
-rw-r--r--  1 node node    16 Sep 15 14:37 other-message
-rw-r--r--  1 node node 12298 Sep 14 13:56 package-lock.json
-rw-r--r--  1 node node   177 Sep 14 13:56 package.json
drwxr-xr-x  2 node node  4096 Sep 14 14:10 src
```

## References

* [Docker docs on volumes](https://docs.docker.com/engine/storage/volumes/)
* [Docker docs on docker run command](https://docs.docker.com/reference/cli/docker/container/run/)
