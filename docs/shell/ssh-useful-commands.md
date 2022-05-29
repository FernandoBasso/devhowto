# Useful SSH Commands

!!! info

    For the commands that follow, let's assume the local user running these
    commands is the user “yoda”.

## Generate private/public keys pair

By default, `ssh-keygen` generates files in `$PWD`. It creates two files:
"id_<key-type>" and "id_<key-type>.pub". We can use `-f` to specify the output
directory (it must be created separately because  `ssh-keygen` does not create
it automatically).  `ssh-keygen` will then create a private key (no extension)
and a public key (with the extension “.pub”).

```shell-session
$ mkdir -pv "$HOME/.ssh"

$ ssh-keygen \
    -t rsa \
    -b 4096 \
    -C 'Master Yoda <yoda@master.io>' \
    -f ~/.ssh/id_master-yoda

Generating public/private rsa key pair.
Enter passphrase (empty for no passphrase):
Enter same passphrase again:
Your identification has been saved in /home/yoda/.ssh/id_master-yoda
Your public key has been saved in /home/yoda/.ssh/id_master-yoda.pub
The key fingerprint is:
SHA256:L6aNdKu9aUNf8KcuovXMO0MR9sYHJwKuEpCktvNRdwo yoda@master.io
The key's randomart image is:
+---[RSA 4096]----+
| .o.    ..       |
| ...   .  + o .  |
|..  .E ..o = +   |
|. . ..o.o o + .  |
| o .. ..S  = .   |
|  o ..  ... o .  |
|   .  ..=o.. o   |
|     . O+B= .    |
|      =+*+=*.    |
+----[SHA256]-----+

$ ls -Al "$HOME/.ssh"
-rw-------  1 yoda yoda 3381 Dec 27 13:44 id_master-yoda
-rw-r--r--  1 yoda yoda  740 Dec 27 13:44 id_master-yoda.pub
```

!!! warn

    Pass the directory **with** the desired filename as well: DO NOT pass only
    the directory to `-f`.

    ```text
    # WRONG:
    -f ~/.ssh

    # CORRECT:
    -f ~/.ssh/id-my-key-file-name
    ```

### References

- [Arch Linux Gitlab instructions to generate an SSH key pair](https://gitlab.archlinux.org/help/ssh/index#generate-an-ssh-key-pair)

## Copy Public SSH Key to Remote Host

In order to be able to login to a remote host using the private key, we must
first copy it to the other machine (the password for the user's machine will
be required at least for this once).

The next command line will append the contents of the local public key to
`/home/your_ssh_user/.ssh/authorized_keys` on the remote host:

```shell-session
$ ssh-copy-id \
    -i ~/.ssh/id_master-yoda.pub \
    someuser@somehost
```

Then try to login with the command below. It should let you login without asking
for the remote host's user password. It should either ask for the private key's
passphrase or ask for nothing at all if the passphrase was created without a
password.

```shell-session
$ ssh \
    -i ~/.ssh/id_master-yoda
    someuser@somehost
```

Note that we provide which identity key file to use with the `-i` command line
option to `ssh`.

## Creating a Config for a Host

Instead of typing a long command line (or relying on retrieving it from the
shell's history), we could add a few lines to `~/.ssh/config` so we could log
into the remote host with a short and quick command line.

Here's one example:

```text title="~/.ssh/config example"
Host jediacademy
  Hostname jediacademy.example.org
  Port 22
  User yoda
  IdentityFile ~/.ssh/id_master-yoda
```

From now on, the user could log into the remote host with this command:

```shell-session
$ ssh jediacademy
```

Even shell Tab-completion should work on most systems, depending on the
shell used and its configuration (works by default with Bash on Arch
Linux, for instance).

## Common Problems

It is not uncommon that we face problems and logins do not work. Let's
name a few here.

### Wrong File Permissions

SSH is very sensitive to file permissions. These are the ones on my machine:

```shell-session
$ stat -c '%A %a %n' ~/.ssh/config ~/.ssh/id_master-yoda*
-rw-r--r-- 644 /home/yoda/.ssh/config
-rw------- 600 /home/yoda/.ssh/id_master-yoda
-rw-r--r-- 644 /home/yoda/.ssh/id_master-yoda.pub
```

!!! info

    Note that the private key is `rw` for my user. The man page says
    it should be `r` only. We won't ever change the contents of the
    private key. It probably got that extra `w` because in general,
    by default, users have the right to write to files they have
    created. We could change that if so inclined to do so:

    ```shell-session
    $ chmod -v u-w ~/.ssh/id_master-yoda
    mode of '/home/yoda/.ssh/id_master-yoda' changed
    from 0600 (rw-------) to 0400 (r--------)
    ```

See `man ssh` and look for the
[*FILES*](https://man.archlinux.org/man/ssh.1#FILES)
section for detailed and precise information.

### Incompatible or Missing Host Key Type

You try to run a simple SSH command and get an error like this:

> Unable to negotiate with _some host or IP_ port 22: no matching
> host key type found. Their offer: ssh-rsa

This has to do with one side of the communication trying to use one algorithm
while the other side does not recognize or accepts it due to the configuration.
In this case, the client — not the server (sshd) — is failing to specify
`ssh-rsa` as the host key signature algorithms that the client wants to use.
So, what we do is to either provide the option on the command line or in the
config file:

```shell-session
$ ssh-copy-id \
    -o 'HostKeyAlgorithms = +ssh-rsa' \
    -i ~/.ssh/id_master-yoda.pub \
    yoda@jediacademy.example.org
```

In the config file, it would look like this:

```text title="~/.ssh/config with extra options"
Host jediacademy
  Hostname jediacademy.example.org
  Port 22
  User yoda
  IdentityFile ~/.ssh/id_master-yoda
  HostKeyAlgorithms = +ssh-rsa
```

!!! note

    Beware of the `+` in front of `ssh-rsa`. It means *append* this
    algorithm rather than replace the existing ones.
