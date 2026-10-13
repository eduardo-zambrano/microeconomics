#!/bin/bash
# Render the book outside Dropbox, then update _book in place.
# (Letting Quarto delete and recreate _book inside Dropbox produces "conflicted copy" files
# and leaves the old version in place.)
set -e
cd "$(dirname "$0")"
TMP="$(mktemp -d)"
quarto render --output-dir "$TMP/_book"
mkdir -p _book
rsync -a --inplace --delete "$TMP/_book/" _book/
rm -rf "$TMP" costs_files index_files
