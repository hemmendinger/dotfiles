# Notes for agents

- This repo is designed for multi-platform use (Windows, macOS, Linux). Keep
  config OS-neutral; branch on the OS inside the config, not in the layout.
- Plain git repo of config files. No symlinks, no dotfiles manager, no sync
  automation. Already decided.
- `emacs/init.el` is the live config. Each machine points at it with a
  one-line `~/.emacs` stub written by `emacs/write-emacs-stub.*`. Edit
  `init.el` only, never the stub.
- `.emacs.d` is per-machine state and stays out of the repo.
- Don't commit or push unless asked.

## Windows only

Shells inside the Claude desktop app see a virtualized `AppData\Roaming`:
writes there don't reach the real folder and `%APPDATA%\.emacs` may look
missing. This is expected and affects only the agent's view. Don't investigate
or report it; anything under `%APPDATA%` is for the user to do from a normal
PowerShell window.
