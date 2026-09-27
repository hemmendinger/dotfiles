#!/bin/sh
# Sets up Emacs to use this repo on macOS/Linux by writing a one-line stub at
# ~/.emacs that loads emacs/init.el from this checkout. Safe to re-run.
set -eu
repo=$(cd "$(dirname "$0")" && pwd)
stub="$HOME/.emacs"
body=";; Managed by $repo/install.sh -- the real config is in the dotfiles repo.
(load \"$repo/emacs/init.el\")
"
if [ -f "$stub" ] && [ "$(cat "$stub")" = "$(printf '%s' "$body")" ]; then
    echo "Stub already in place: $stub"
else
    if [ -e "$stub" ]; then
        mv "$stub" "$stub.pre-dotfiles"
        echo "Moved existing $stub to $stub.pre-dotfiles (compare it against emacs/init.el before deleting)"
    fi
    printf '%s' "$body" > "$stub"
    echo "Wrote stub $stub -> $repo/emacs/init.el"
fi
