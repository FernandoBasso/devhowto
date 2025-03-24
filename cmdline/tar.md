---
description: Some practical examples on using the tar command to pack and unpack archives.
---

# tar

## Pack Excluding Directories

Useful command to create an archive of a React/Vue.js where we want avoid including `node_modules` and `dist` directories:

```shell-session
$ tar \
    --exclude './myapp-poc1/node_modules' \
    --exclude './myapp-poc1/dist' \
    -cf myapp-poc1.tar \
    ./myapp-poc1

$ du -h myapp-poc1.tar
800K	myapp-poc1.tar
```
