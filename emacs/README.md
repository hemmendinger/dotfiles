# Emacs

`init.el` is the whole config. Emacs does not look here for it, so each machine
needs a stub `~/.emacs` containing one line: `(load "<this dir>/init.el")`.

## When to run the stub scripts

Run once per machine, right after cloning the repo, then never again unless
the repo moves. Editing `init.el` never requires re-running them.

- Windows: `write-emacs-stub.ps1`, from a normal PowerShell window (not a shell
  inside the Claude desktop app; it refuses there because that app virtualizes
  `AppData\Roaming`). Writes `%APPDATA%\.emacs`.
- macOS / Linux: `write-emacs-stub.sh`. Writes `~/.emacs`.

Both back up an existing `.emacs` as `.emacs.pre-dotfiles` and are safe to
re-run.

## What stays out of the repo

`.emacs.d` (packages, saved desktop, backups, server socket) is per-machine
state. Packages are listed in `package-selected-packages` in `init.el`; restore
them with `M-x package-install-selected-packages`. Customize output goes to
`custom.el` in `.emacs.d`, not into `init.el`.
