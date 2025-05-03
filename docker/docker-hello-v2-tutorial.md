---
description: A continuation on the hello v1 tutorial, now we explor ideas and concepts on how to keep a container running until asked to stop.
---

# Tutorial Docker Hello World 2

## Introduction

In the hello-v1 example we just echoed a message.
The container printed the message and exited.

How can we make a container start and then keep running?
The answer lies with the `CMD` instruction.
Whenever a process that gets run with `CMD` keeps running, the container also keeps running (unless it is stopped by other means, like with `docker container stop <container>` command).

Therefore, let’s write a script that keeps running for some time, and then run that script in `CMD` to keep the container running.

And because the container will keep running for some time, it will also allow us to shell into the container and run some commands there.

:::{note}
As we keep changing the `Dockerfile` while progress through the example(s), remember to rebuild the image each time before running it as a container so the new changes are reflected.
:::

## Initial setup

Create a directory and a `Dockerfile` inside it.
Something like this should do:

```bash
$ mkdir -pv ~/docker-examples/hello-v2
$ cd !$

$ 1> ./Dockerfile :

$ tree -CFa .
./
└── Dockerfile
```

## The bash script

Let’s create a shell script under a filename called `loop.sh`.
Write this code into the file:

**loop.sh**

```bash
#!/usr/bin/env bash

##
# Loops from 1 to 100 with a two-second interval between
# each int and, printing each of them in turn.
#
for i in {1..100}
do
  printf '%d\n' $i
  sleep 2
done
```

We’ll not even make this script executable (even though we could), but simply run it with `bash`.
Let’s test it:

```bash
$ bash ./loop.sh
1
2
3
...
```

Hit kbd:[Ctrl+C] to stop execution.

Let’s use that script as our program to be run in the `CMD` instruction of our docker image.

## Dockerfile

```yaml
FROM debian:latest

WORKDIR /myapp

COPY ./loop.sh /myapp

CMD ["bash", "./loop.sh"]
```

## Build the image

Then build and list the images:

```bash
$ docker build --tag hello-v2:latest .

$ docker image ls
REPOSITORY       TAG       IMAGE ID       CREATED         SIZE
hello-v2         latest    a701e38b0728   1 minute ago    117MB
hello-v1         latest    0b551cf480e4   8 days ago      117MB
```

The line `WORKDIR /myapp` sets the working directory for processes when the image is run as a container.
It means, for example, that if we were to run `ls`, it would run `ls` from `/myapp` directory (inside the container), not from `/` or some other directory.

Then, we use the `COPY` instruction to copy `loop.sh` from our host, local file system into `/myapp` inside the image.

Finally, we use the `CMD` instruction to essentially run `loop.sh` with `bash`.

## Run the image as a container

Run the container and observe it will keep your shell busy, printing one number at a time with a two-second interval between each:

```bash
$ docker run --rm --name my_container hello-v2:latest
1
2
3
...
```

Observe we used `--name my_container` so we give it an easily recognizable name that will help us with further commands.

## Shell into the running container

While the script doesn’t finish running, the container will also keep running, which means we can inspect the running container and shell into it.

Open another terminal session to try the next commands.

```bash
$ docker container ls
CONTAINER ID   IMAGE             COMMAND             NAMES
20e38ded7dea   hello-v2:latest   "bash ./loop.sh"    my_container
```

:::{note}
Some non-relevant (for our purposes at least) columns from the output were removed to save space.
:::

We can then log into (or shell into) the container.
The Debian image has bash available, so let’s use bash as our shell inside the container:

**Shell into the container**

```text
$ docker exec -it my_container /bin/bash

root@1ee63ecbf730:/myapp# ls -a
.  ..  loop.sh

root@1ee63ecbf730:/myapp# 1> ./other.txt echo Hello

root@1ee63ecbf730:/myapp# cat ./other.txt
Hello

root@1ee63ecbf730:/myapp# bash ./loop.sh
1
2
3
^C

root@1ee63ecbf730:/myapp# exit
exit

$
```

The first thing to note is that when we got a shell into the container, our working directory was `/myapp`, exactly as we specified in the `Dockerfile` with the `WORKDIR` instruction.

Also, we were able to run shell commands _inside_ the container.

Then we exited from the container shell and got back to the host system shell.

If we let the script run to 100, there is nothing more to run, and the container stops running as well.

If the process executed with `CMD` finishes while we are within a shell session inside the container, that shell session (inside the container) is terminated and we are kicked back into the host system shell.

:::{note}
The `-i -t` (or `-it`) options are short for `--interactive` and `--tty`.
Basically, `--interactive` keeps the session open (we get a way to actually connect with STDIN, STDOUT and STDERR on the container), while `--tty` gives us a prompt to work with.

Try `docker exec` as above but without those options, or with only one or the other of them at a time to see what happens and you’ll get a better idea about why they are important and useful.
:::

Any process that keeps running as part of the `CMD` instruction will keep the container up and running as well.

This means, for example, that this would keep the container running indefinitely (until stopped through some other means):

```yaml
CMD ["tail", "-f", "/etc/hostname"]
```

And this would keep it running for 256 seconds.

```yaml
CMD ["sleep", "256"]
```

## Compound shell commands

What if we want to run something like `sleep 2 && echo DONE`?
Suppose we try this (spoiler alert: it will not work):

**Dockerfile**

```yaml
CMD ["sleep", "4", "&&", "echo", "DONE"]
```

And then rebuild and run the image:

```bash
$ docker build --tag hello-v2:latest .

$ docker run --rm --name my_container hello-v2:latest
sleep: invalid time interval '&&'
sleep: invalid time interval 'echo'
sleep: invalid time interval 'DONE'
Try 'sleep --help' for more information.
```

No, that won’t do.
Yet, we can achieve it using `bash -c`.
For instance, try this on your host system shell:

```bash
$ bash -c 'sleep 2 && echo DONE'
```

And then modify `Dockerfile`.
Be mindful of how we parameterize it in terms the individual pieces of the whole command.
That is, we have `"bash"`, then `"-c"`, then all the rest in a single string.
You can see how the pieces match the previous example above.

**Dockerfile **

```
CMD ["bash", "-c", "sleep 4 && echo DONE"]
```

Then it should work:

```text
$ docker build --tag hello-v2:latest .

$ docker run --rm --name my_container hello-v2:latest
(no output for 2 secons, then)
DONE
```

:::{note}
Quoting is an important (and sometimes tricky) part of shells.
There is no single “solution” for how we should quote or parameterize commands and parameters for the various tools.
It requires research, a lot of reading, and a good deal of hands-on practice.

We’ll try to show other examples in other parts of these tutorials.
:::

## References

* [Dockerfile docs](https://docs.docker.com/reference/dockerfile).
* [docker exec docs](https://docs.docker.com/reference/cli/docker/container/exec/#options).
