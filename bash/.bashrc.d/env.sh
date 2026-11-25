# .bashrc.d/env.sh

# Auto-start tmux and close terminal on detach/exit
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ] && [ "$TERM_PROGRAM" != "vscode" ]; then
    exec tmux new-session -A -s main
fi

# Set nvim as default text editor
export EDITOR=/usr/bin/nvim

# Improve history
HISTTIMEFORMAT="%F %T  "
HISTSIZE=-1
HISTFILESIZE=-1
export HISTCONTROL=ignoreboth
shopt -s histappend
PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND:-}"

# Store configs in .config
export SCIKIT_LEARN_DATA="$HOME/.cache/scikit_learn_data"

# Ctrl+S to cycle forward in command history
stty -ixon

# source Cargo (Rust)
source "$HOME/.cargo/env"

