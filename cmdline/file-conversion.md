# File Conversion

## Asciidoc[tor] to Markdown

Pandoc can't convert directly from Asciidoc to Markdown.
So, first convert Asciido[ctor] files to Docbook and then convert Docbook files to Markdown (gfm here):

```bash
for f in *.adoc ; do asciidoctor -b docbook "$f" ; done

for f in *.xml ; do
	pandoc -s "$f" -f docbook "$f" -t gfm --wrap=none -o "${f%.*}.md"
done
```

Remove the .xml files (and possibly the .adoc files):

```shell-session
rm -v *.xml
```

## reStructuredText (.rst) to Markdown (.md)

```bash
#!/usr/bin/env bash

#
# Converts all .rst files in the current directory to .md.
#
# Requires pandoc.
#

for f in *.rst
do
  pandoc \
		--verbose \
    --standalone \
    --from=rst \
    "$f" \
    --to=gfm \
    --wrap=none \
    --output="${f%.*}.md"
done
```
