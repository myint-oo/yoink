# zsh

Install Oh My Zsh. Theme `robbyrussell`, plugins: `git`.

In `~/.zshrc`, after Oh My Zsh loads:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

macOS: `~/.zprofile` loads Homebrew:

```sh
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
```
