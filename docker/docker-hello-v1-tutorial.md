---
description: This post explores an example of using Docker to print a shell message and exit. Important foundational concepts are explained in this example.
---

# Tutorial Docker Hello World 1

## Introduction

Let’s being our journey learning Docker with a basic example which uses a Debian image and simply prints a message to the console and then exits.

## Initial setup

Create a directory and a `Dockerfile` inside it.
Something like this should do:

```bash
$ mkdir -pv ~/docker-examples/hello-v1
$ cd !$

$ 1> ./Dockerfile :

$ tree -CFa .
./
└── Dockerfile
```

## Dockerfile

Let’s start with of the most basic `Dockerfile` possible: an example that simply echoes a message and then exits.

**Dockerfile**

```yaml
FROM debian:latest

CMD ["echo", "Hello Debian on Docker 💯"]
```

## Build the image

Then build the image:

```bash
$ docker build --tag hello-v1:latest .
```

Check the image was built:

```bash
$ docker image ls
REPOSITORY       TAG       IMAGE ID       CREATED       SIZE
hello-v1         latest    ef2c51bceec9   7 days ago    117MB
```

The ID, CREATED and SIZE columns will differ on your machine.

:::{note}
It says CREATED 7 days ago because the base image used was last built 7 days ago and we are not making any modifications to the image itself, but just using it.
The CREATED date gets set to the build date of the highest layer.

- https://stackoverflow.com/questions/61726957/new-image-show-created-as-2-weeks-and-4-months-ago-inside-docker
- https://github.com/moby/moby/issues/34786
:::

## Run the image as a container

We are finally able to run the image:

```bash
$ docker run --rm hello-v1:latest
Hello Debian on Docker 💯
```

:::{tip}
The `--rm` flag is useful when we want to avoid having a lot of stopped containers and anonymous volumes hanging around.
It helps to keeps things cleaner.
:::

If we want to update the message, it is necessary to build the image again so the next time it runs, it will print the new message.

## Important considerations

After the message is echoed to STDOUT, the container stops running.
The process exits with the same exit status of the command run inside the container.
That means, for example, that if we change the command to run an `ls` command on a file that does not exist, that `ls` will return an exit status other than 0, and that same status is reported back to the host system.

**Dockerfile**

```yaml
FROM debian:latest
CMD ["ls", "./does-not-exist.txt"]
```

```bash
$ docker build --tag hello-v1:latest .

$ docker run --rm hello-v1:latest
ls: cannot access './does-not-exist.txt': No such file or directory

$ echo $?
2
```

:::{tip}
On UNIX-like and other operating systems, an exit status of 0 means _success_, and any other non-zero exit status means some sort of _failure_.
Some tools and commands document the different exit status for non-success cases.
Still, in most case, just knowing that 0 means success and non-zero means some sort of failure is enough for scripting, automation, reporting, etc.
:::

