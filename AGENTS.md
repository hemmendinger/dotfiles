# Notes for agents

## General

- Research before improvising; it may be a known, solved problem with a
  cleaner solution.
- Present design choices before building: list the options with a
  recommendation and wait.
- Favor the best practices that guide software engineers.
- Multi-platform by design (Windows, macOS, Linux). Keep config OS-neutral;
  branch on the OS inside a config file, not in the repo layout.
- Plain git repo of config files, one directory per program, each with its own
  README. No symlinks, no dotfiles manager, no sync automation. Already decided.
- Machine-generated state (caches, sessions, installed packages) stays out.
- Don't commit or push unless asked.

## Emacs

- `emacs/init.el` is the live config. Each machine points at it with a
  one-line `~/.emacs` stub written by `emacs/write-emacs-stub.*`. Edit
  `init.el` only, never the stub.
- `.emacs.d` is per-machine state and stays out of the repo.

## Windows only

Shells inside the Claude desktop app see a virtualized `AppData\Roaming`:
writes there don't reach the real folder and files there may look missing. This
is expected and affects only the agent's view. Don't investigate or report it
unless it is causing a problem; anything under `%APPDATA%` is for the user to
do from a normal PowerShell window.
