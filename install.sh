#!/bin/sh

zshrc() {
    echo "==========================================================="
    echo "             cloning zsh-autosuggestions                   "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    echo "==========================================================="
    echo "             cloning zsh-syntax-highlighting               "
    echo "-----------------------------------------------------------"
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    echo "==========================================================="
    echo "             cloning powerlevel10k                         "
    echo "-----------------------------------------------------------"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    echo "==========================================================="
    echo "             import zshrc                                  "
    echo "-----------------------------------------------------------"
    cat .zshrc > $HOME/.zshrc
    echo "==========================================================="
    echo "             import powerlevel10k                          "
    echo "-----------------------------------------------------------"
    cat .p10k.zsh > $HOME/.p10k.zsh
}

zshrc

# make directly highlighting readable - needs to be after zshrc line
echo "" >> ~/.zshrc
echo "# remove ls and directory completion highlight color" >> ~/.zshrc
echo "_ls_colors=':ow=01;33'" >> ~/.zshrc
echo 'zstyle ":completion:*:default" list-colors "${(s.:.)_ls_colors}"' >> ~/.zshrc
echo 'LS_COLORS+=$_ls_colors' >> ~/.zshrc

# set gitconfig defaults
git config --global push.autoSetupRemote true
git config --global core.editor "code --wait"
git config --global alias.st status
git config --global alias.ad add
git config --global alias.ct commit
git config --global alias.cta 'commit --amend'
git config --global alias.pu push
git config --global alias.pl pull
git config --global alias.co checkout
git config --global alias.br branch
git config --global alias.df diff
git config --global alias.dfs 'diff --staged'
git config --global alias.dfc 'diff --cached'
git config --global alias.mr merge
git config --global alias.rb rebase
git config --global alias.sta stash
git config --global alias.staa 'stash apply'
git config --global alias.pfo 'push --force-with-lease'

#!/bin/zsh

# Don't track vscode settings.json file in git locally
git update-index --skip-worktree .vscode/settings.json

# Path to the settings.json file
file_path=".vscode/settings.json"

# Temporary file
temp_file=$(mktemp)

# awk script to replace the content between { and } for the [ruby] key
awk '
BEGIN { print_mode = 1 }
/"\[ruby\]": \{/ {
    print "    \"[ruby]\": {"
    print "        \"editor.defaultFormatter\": \"rubocop.vscode-rubocop\","
    print "        \"editor.formatOnSave\": true,"

    print_mode = 0
    next
    }
/},/ {
    if (print_mode == 0) {
        print_mode = 1
        print "    },"
        print "    \"rubocop.commandPath\": \"bin/rubocop\","
        next
    }
}
print_mode { print }
' "$file_path" > "$temp_file"

# Move the temporary file to the original file path
mv "$temp_file" "$file_path"

echo "settings modified successfully"

