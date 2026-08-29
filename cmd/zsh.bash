export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git direnv fzf)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='hx'
fi


# Manually added
. "$HOME/.cargo/env"
export PATH=~/.local/bin/:$PATH

#export PATH="$HOME/Library/Java/JavaVirtualMachines/azul-17.0.14-intel/Contents/Home:$PATH"
#export JAVA_HOME="$HOME/Library/Java/JavaVirtualMachines/azul-17.0.14-intel/Contents/Home"

fpath+=~/.zfunc; autoload -Uz compinit; compinit

eval "$(uv generate-shell-completion zsh)"
zstyle ':completion:*' menu select


alias python3=python3.13

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Amp CLI
export PATH="$HOME/.amp/bin:$PATH"

export TERMINAL="ghostty"
alias claude="claude --allow-dangerously-skip-permissions"
alias cc="claude"
alias codex="codex --dangerously-bypass-approvals-and-sandbox"


# Added by Antigravity
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"

export PATH="$HOME/dev/llama.cpp/build/bin:$PATH"
export PATH="$PATH:$(go env GOPATH)/bin"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# kimi-code
export PATH="$HOME/.kimi-code/bin:$PATH"
