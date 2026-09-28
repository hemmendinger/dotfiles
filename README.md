# dotfiles

Plain git repo, no dotfiles manager. Each program's config lives here and the
machine gets a one-line pointer to it, so an edit in this repo is live on the
next start of the program.

## Emacs

`emacs/init.el` is the whole config; it branches on `system-type` for OS
differences. Emacs finds it through a stub `~/.emacs` containing only
`(load "<repo>/emacs/init.el")`. Customize output goes to `custom.el` in
`user-emacs-directory` (per machine, not in the repo).

### Windows

Open a normal PowerShell window (not a shell inside the Claude desktop app,
which sees a virtualized `AppData\Roaming`; the script detects that and
refuses) and run:

```powershell
G:\projects\dotfiles\emacs\write-emacs-stub.ps1
```

This writes `%APPDATA%\.emacs`, backing up any existing file as
`.emacs.pre-dotfiles`.

### macOS / Linux

```sh
git clone https://github.com/hemmendinger/dotfiles.git ~/projects/dotfiles
~/projects/dotfiles/emacs/write-emacs-stub.sh
```

Not tracked, on purpose: `.emacs.d` (packages, saved desktop, backups). Packages
are listed in `package-selected-packages` in `init.el`; on a new machine run
`M-x package-install-selected-packages`.
