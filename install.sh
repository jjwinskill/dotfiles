#!/bin/bash

# Install oh-my-zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Ensure Zsh is the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
  chsh -s $(which zsh)
fi

# Install powerlevel10k for better theme options
if [ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]; then
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git $HOME/.oh-my-zsh/custom/themes/powerlevel10k
fi

# Set powerlevel10k theme in .zshrc
sed -i '' 's/^ZSH_THEME=".*"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' $HOME/.zshrc

# Append customizations to .zshrc
cat << 'EOF' >> $HOME/.zshrc

# Custom theme settings for Synth '84
function prompt_git_branch {
  git branch 2>/dev/null | grep '*' | sed 's/* //'
}

PROMPT='%{$fg[cyan]%}%n@%m %{$fg[magenta]%}%~ %{$fg[green]%}$(prompt_git_branch)%{$reset_color%} %# '

# Git Aliases
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gca='git commit --amend'
alias gp='git push'
alias gl='git pull'
alias gco='git checkout'
alias gb='git branch'
alias gd='git diff'
alias gds='git diff --staged'
alias gdc='git diff --cached'
alias gm='git merge'
alias gr='git rebase'
alias gst='git stash'
alias gsta='git stash apply'

# Tab-completion for git branch names
if [[ $commands[git] ]]; then
  __git_complete gco _git_checkout
  __git_complete gb _git_branch
fi

# Path to your oh-my-zsh installation.
export PATH=$HOME/bin:/usr/local/bin:$PATH

# Other environment settings
export EDITOR='code --wait'

# Apply the color scheme
autoload -U colors && colors
EOF

# Apply the changes
source $HOME/.zshrc
