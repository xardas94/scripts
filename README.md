# Scripts
## Utils
- **delta_wrapper** -- resize window before calling delta
- **hg** -- ripgrep wrapper to enable hyperlink in format `file:line`
- **hgp** -- ripgrep wrapper with syntax highlight (requires [delta](https://dandavison.github.io/delta/)) piped to a pager
- **open_at** -- tries to open hyperlink `file:line` at `line`
- **quick_cmds** -- select command and send it to [wezterm](https://wezfurlong.org/wezterm/index.html) (requires [dmenu](https://tools.suckless.org/dmenu/))
- **пше** -- transliterate git command misstyped in UA keyboard layout: `пше вшаа -> git diff` (optional [timg](https://github.com/hzeller/timg), [SoX](https://sourceforge.net/projects/sox/))

## X11-utils:
- **toggle_app** -- my [drawer](https://github.com/lharding/lsh-bin/blob/master/drawer) implementation
- **opacity.sh** -- change opacity of the current window
- **scroll_workspace.sh** -- switch between workspaces(desktops)
- **toggle_decoration.sh** -- toggle the current window's decoration

## Instalation
Clone the repo (from your $HOME directory):
```
git clone https://github.com/xardas94/scripts.git && cd scripts
```
Install scripts:
> Make sure `$HOME/.local/bin` exists and is in your `$PATH`
```
stow -R --dotfiles utils
stow -R --dotfiles X11-utlis
```
Remove scripts:
```
stow -D --dotfiles utlis
stow -D --dotfiles X11-utlis
```
