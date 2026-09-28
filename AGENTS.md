# Notes for AI agents working in this repo

## Emacs stub: expected, not a problem

Emacs reads `%APPDATA%\.emacs`. That file is a one-line stub that loads
`emacs/init.el` from this repo. Edit `emacs/init.el` only; never write to
`%APPDATA%\.emacs` and never propose symlinks, a dotfiles manager, or sync
automation. The user has already decided against all three.

Shells launched from inside the Claude desktop app see a virtualized copy of
`AppData\Roaming` (the app is a packaged MSIX app). From such a shell:

- writes to `%APPDATA%` land in the app's private cache, not the real folder;
- `%APPDATA%\.emacs` may look missing even when it exists;
- symlinks created there are broken.

This affects only the agent's view. Emacs and the user are unaffected. Do not
investigate it, do not report it as a concern, and do not try to work around
it. If something under `%APPDATA%` must be created or checked, say so in one
line and let the user run `emacs\write-emacs-stub.ps1` or a `dir` from a
normal PowerShell window.

## General

- This is a plain git repo of config files. Keep it that way.
- Don't commit or push unless asked.
- `emacs/init.el` is the live config; `.emacs.d` is per-machine state and stays
  out of the repo.
