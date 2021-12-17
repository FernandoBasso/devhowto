# Exercism

## Intro

Contrary to Codewars, Exercism doesn't seem to have the same challenges across
different languages. Their approach is to have challenges that focus on the
languages attributes and features. Therefore, the code and site do not group
solutions by challenge (like in Codewars), but instead, it the solutions are
grouped by language track.

## Solutions Versions

I sometimes solve the same exercise in multiple ways, using different
approaches, and end up naming them with the “v1”, “v2”, “v3”, etc.
suffixes. That doesn't mean that greater versions are necessarily
better. Sometimes v3 is worse than v2 in some aspects, while better in
others, etc. It may be the case that the first few versions are more
procedural and verbose, and perhaps the later versions a little more
clever or using a more functional style, though. Yet, my intention is to
experiment with different solutions and not to imply that some are
better than others.

## My Setup

This is how I setup exercism on my Arch Linux machine.

```shell title="Exercism setup on Linux"
$ tar \
    -xf exercism-linux-64bit.tgz \
    --directory ~/bin/exercism-linux/

$ ln -sv ~/bin/exercism-linux/exercism ~/bin/exercism

# (1)
$ cat <<EOF >> ~/.bash_profile
#
# https://exercism.org/cli-walkthrough
#
source ~/bin/exercism-linux/shell/exercism_completion.bash
EOF

$ source ~/.bash_profile

$ exercism configure \
    --token='the token from the exercism cli-walkthrough page' \
    --workspace ~/work/src/devhowto/src/exercism
```

1. You may need to hit `Ctrl+d` to run/finish the `cat` command.

!!! tip "~/.bash_profile, ~/bashrc adn login shells"

    Make sure your terminal is configured to run as a login shell
    otherwise `~/.bash_profile` is not read by default. As an
    alternative, add the config line to `~/.bashrc` instead.

    ```shell title="setup shell completion to ~/.bashrc"
    $ cat <<EOF >> ~/.bashrc
    #
    # https://exercism.org/cli-walkthrough
    #
    source ~/bin/exercism-linux/shell/exercism_completion.bash
    EOF
    ```

