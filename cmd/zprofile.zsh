
# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

eval "$(/opt/homebrew/bin/brew shellenv zsh)"

# Prefer user safety wrappers (including the guarded rm) over system binaries.
export PATH="$HOME/.local/bin:$PATH"
export PATH="/Library/TeX/texbin:$PATH"
