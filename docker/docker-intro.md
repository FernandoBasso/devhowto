---
description: My notes, tips, ideas and example on creating, running and managing docker containers.
---

# Docker

## Requirements for learning Docker

To have a good grasping of working with Docker, it is essential that we have a solid understanding of Unix (most specifically Linux) operating system, command line and shells, and also networking, and quite frankly, make related topics.
Almost everything we do with Docker ends up needing that sort of knowledge and experience.

Moreover, understanding the tools we want to run in Docker is a must as well.
For example, to run a database like PostgreSQL in Docker, besides knowing Docker and Linux and whatnot (as mentioned above), knowing how PostgreSQL itself is supposed to be managed, configured, fine tuned, etc. is important.
Understanding of PostgreSQL roles, users, replication, etc. are all part of the deal.

In short, a lot of stuff has to be understood together.

That said, there is not problem in learning on demand as we figure out other things we are still lacking.
We can research on topics as they become important or necessary on our daily routines.

## ArchLinux on MacOS m2

```bash
FROM --platform=linux/x86_64 archlinux:latest
CMD ["echo", "It works!"]
```

```text
$ docker build --tag hello:latest --file ./Dockerfile1 .
DEPRECATED: The legacy builder is deprecated and will be removed in a future release.
            Install the buildx component to build images with BuildKit:
            https://docs.docker.com/go/buildx/

Sending build context to Docker daemon  73.73kB
Step 1/3 : FROM archlinux:latest
latest: Pulling from library/archlinux
no matching manifest for linux/arm64/v8 in the manifest list entries
```

We need to specify the platform:

```shell-session
$ docker build --tag hello:latest --file ./Dockerfile1 .

$ docker run hello:latest
WARNING: The requested image's platform (linux/amd64) does not match
the detected host platform (linux/arm64/v8) and no specific platform
was requested
It works!

docker [go-1.23.1]
$ docker run --platform=linux/x86_64 hello:latest
It works!
```

* https://stackoverflow.com/questions/65456814/docker-apple-silicon-m1-preview-mysql-no-matching-manifest-for-linux-arm64-v8

## Container always runs automatically

Sometimes, when we start the docker service on a Linux machine, or start colima on macOS, it can happen than one or more containers always run automatically.
It may happen when we have previously run a container with `--restart=allways`.

In my case, it was because I had `restart: always` in `docker-compose.yml` in one of my projects:

```{code} yaml
:linenos:
:emphasize-lines: 5
services:
  db:
    image: postgres:17
    container_name: myproj
    restart: always
    env_file: .env
    ports:
      - "5432:5432"
    volumes:
      - "pg_myproj_db_data:/var/lib/postgresql/data"
      - "./docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d"
      - "./dbdumps/:/dbdumps"
```

One solution is to update the configuration for the container(s) in question.

```{code} bash
$ docker container update --restart no
```

Of course, if we have `restart: always` in the `docker-compose.yml` file, it could be applied the next time that container is run depending on other things, like whether we run it with `--rm` or not.
So maybe we'd want to write `restart: no` in our compose file.

As of docker 28 (in 2025), these are the known values for the *restart* policy:

- `always`
- `no`
- `on-failure`
- `on-failure:[max-retries]`
- `unless-stopped`

### References

- [Docker docks on container update](https://docs.docker.com/reference/cli/docker/container/update/)
- [Docker docks on restart policies](https://docs.docker.com/engine/containers/start-containers-automatically/#use-a-restart-policy)

## Docker entrypoint initdb.d shell script error

### The Initial Setup

While working on a certain project, we were using PostgreSQL in Docker.
The setup was initially done on a Linux machine.
We had this folder structure:

```text
$ tree .
.
├── api
│   ├── foo.hs
│   ├── bar.hs
│   └── server.hs
├── docker
│   ├── docker-compose.yml
│   └── docker-entrypoint-initdb.d
│       └── 01.sh
├── main.hs
├── Makefile
└── README.adoc
```

The file `docker-compose.yml`, among other things, had this setup for the DB service:

```yaml
services:
  db:
    image: postgres:16
    container_name: our_container
    restart: always
    env_file: .env
    ports:
      - 5432:5432
    volumes:
      - "db_data:/var/lib/postgresql/data"
      - "./docker-entrypoint-initdb.d:/docker-entrypoint-initdb.d"
```

The shell script itself basically consisted of some `psql` commands to add some initial stuff to the server:

```sh
#!/bin/bash

psql \
	-v ON_ERROR_STOP=1 \
	--username "$POSTGRES_USER" \
	--dbname admin <<-EOSQL
	CREATE ROLE $PG_DEV_USER \
	WITH \
		CREATEDB REPLICATION \
		LOGIN PASSWORD '$PG_DEV_PASSWORD' \
	VALID UNTIL 'infinity';
EOSQL

psql -v ON_ERROR_STOP=1 \
	--username "$PG_DEV_USER" \
	--dbname admin <<-EOSQL
	CREATE DATABASE ourdb WITH \
			ENCODING='UTF8' \
			OWNER=$PG_DEV_USER \
			LC_CTYPE='en_US.UTF-8' \
			LC_COLLATE='en_US.UTF-8' \
			TEMPLATE=template0 \
			CONNECTION LIMIT=3;
EOSQL

psql -v ON_ERROR_STOP=1 \
	--username "$PG_DEV_USER" \
	--dbname ourdb <<-EOSQL

CREATE TABLE users ( \
	id VARCHAR(32) PRIMARY KEY \
);

INSERT INTO users ( \
		id \
) VALUES \
('yoda'), \
('aayla'), \
('ahsoka');
EOSQL
```

### File not round error

Later, another engineer fetched the code, did some changes do `01.sh` tried ran `docker compose up` inside the `docker` directory.
The command ran, but the container failed to execute `01.sh` with a message similar to this one:

```text
cannot execute
file not found
```

### The Solution

The problem ended up being Windows style of newlines, which uses `CRLF`, causing `bash` inside the container to fail to run the shell script.

We simply rewrote the file with Linux `LF` newlines, and then the problem was solved.


