#!/bin/sh
# Same as sync.ps1: commit tracked changes, rebase onto upstream, push.
# Aborts cleanly on conflict. Logs to .sync.log. Run by hand or from a scheduler.
repo=$(cd "$(dirname "$0")" && pwd)
log="$repo/.sync.log"
note() { echo "$(date +%FT%T) $*" >> "$log"; echo "$*"; }
cd "$repo" || exit 1
git add -u
if ! git diff --cached --quiet; then
    git commit -q -m "Auto-sync from $(hostname)" && note "committed local changes"
fi
git fetch -q origin || { note "ERROR: fetch failed"; exit 1; }
if ! git rebase -q '@{u}' >/dev/null 2>&1; then
    git rebase --abort >/dev/null 2>&1
    note "CONFLICT: rebase onto upstream failed and was aborted; resolve by hand"
    exit 1
fi
ahead=$(git rev-list --count '@{u}..HEAD')
if [ "$ahead" -gt 0 ]; then git push -q origin HEAD && note "pushed $ahead commit(s)"; else echo "up to date"; fi
