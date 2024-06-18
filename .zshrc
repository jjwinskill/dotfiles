# Path to your oh-my-zsh installation
export ZSH="$HOME/.oh-my-zsh"

# Set theme to powerlevel10k if installed, else use default
if [ -d "$ZSH/custom/themes/powerlevel10k" ]; then
  ZSH_THEME="powerlevel10k/powerlevel10k"
else
  ZSH_THEME="robbyrussell"
fi

# Enable plugins
plugins=(git)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Custom theme settings for Synth '84
function prompt_git_branch {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}

PROMPT='%{$fg[cyan]%}%n@%m %{$fg[magenta]%}%~ %{$fg[green]%}$(prompt_git_branch)%{$reset_color%} %# '

# Git Aliases
alias st='git status'
alias ad='git add'
alias ct='git commit'
alias cta='git commit --amend'
alias pu='git push'
alias pl='git pull'
alias co='git checkout'
alias br='git branch'
alias df='git diff'
alias dfs='git diff --staged'
alias dfc='git diff --cached'
alias mr='git merge'
alias rb='git rebase'
alias sta='git stash'
alias staa='git stash apply'
aleas pfo='git push --force-with-lease'

# Tab-completion for git branch names
if [[ $commands[git] ]]; then
  __git_complete gco _git_checkout
  __git_complete gb _git_branch
fi

# Other environment settings
export PATH=$HOME/bin:/usr/local/bin:$PATH
export EDITOR='code --wait'

# Apply the color scheme
autoload -U colors && colors
