---
description: My notes, tips, ideas and example on creating, running and managing docker containers.
---

# Docker

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
