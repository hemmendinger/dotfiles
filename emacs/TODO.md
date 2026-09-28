# Emacs TODO

Things to do with the Emacs config. Not implemented yet.

- [ ] Line numbers on by default
  - `(global-display-line-numbers-mode 1)`, built in since Emacs 26
- [ ] markdown-mode for `.md` files
  - `markdown-mode` package from MELPA; no built-in Markdown mode
  - init.el does not add MELPA yet; do that first
- [ ] Default encoding: UTF-8, no BOM
  - Emacs still detects other encodings per file
- [ ] Default new files to LF line endings, on every OS
  - `utf-8-unix` via `prefer-coding-system` and `buffer-file-coding-system`
  - existing files keep their line endings
- [ ] Clipboard and terminal coding systems
  - Windows: `(set-clipboard-coding-system 'utf-16le)`
  - elsewhere: `set-terminal-coding-system` and `set-keyboard-coding-system` to `utf-8`
  - test on each machine

## Deferred

- [ ] Font with coding ligatures and emojis
  - ligature fonts: Fira Code, JetBrains Mono, Cascadia Code
  - ligatures need `ligature.el` or `composition-function-table`
  - emojis need a separate fallback font via `set-fontset-font`
    (Noto Color Emoji, Segoe UI Emoji, Apple Color Emoji)
  - Windows needs the HarfBuzz build of Emacs
