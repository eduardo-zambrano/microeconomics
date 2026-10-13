#!/bin/bash
# Build the book outside Dropbox, then update _book in place.
# Rendering inside Dropbox is unreliable: Dropbox touches Quarto's intermediate files
# mid-build (random LaTeX failures) and, when _book is deleted and recreated, produces
# "conflicted copy" files and restores the stale build.
set -e
cd "$(dirname "$0")"
TMP="$(mktemp -d)"
rsync -a --exclude _book --exclude .git --exclude .quarto --exclude '*_files' ./ "$TMP/src/"
(cd "$TMP/src" && quarto render)
mkdir -p _book
rsync -a --inplace --delete "$TMP/src/_book/" _book/
rm -rf "$TMP"
