#!/bin/sh
# Writes the one-line stub ~/.emacs that makes Emacs load the init.el next to
# this script. Safe to re-run.
set -eu
repo=$(cd "$(dirname "$0")" && pwd)
stub="$HOME/.emacs"
body=";; Managed by $repo/write-emacs-stub.sh -- the real config is in the dotfiles repo.
(load \"$repo/init.el\")
"
if [ -f "$stub" ] && [ "$(cat "$stub")" = "$(printf '%s' "$body")" ]; then
    echo "Stub already in place: $stub"
else
    if [ -e "$stub" ]; then
        mv "$stub" "$stub.pre-dotfiles"
        echo "Moved existing $stub to $stub.pre-dotfiles (compare it against emacs/init.el before deleting)"
    fi
    printf '%s' "$body" > "$stub"
    echo "Wrote stub $stub -> $repo/init.el"
fi
