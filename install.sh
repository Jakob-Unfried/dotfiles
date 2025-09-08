

# copy existing dotfiles to temporary directory
# -----------------------------------------------------
cd ~
TMPDIR=".tmp_dotfiles"
if [[ ! -e $TMPDIR ]]; then
    mkdir "$TMPDIR"
else [[ ! -d $TMPDIR ]]
    echo "$TMPDIR already exists. Clean up first, e.g.: 'rm -r ~/.tmp_dotfiles'"
    exit 1
fi
mv ~/.gitconfig $TMPDIR/.gitconfig
mv ~/.pdbrc $TMPDIR/.pdbrc
mv ~/.condarc $TMPDIR/.condarc
mv ~/.vimrc $TMPDIT/.vimrc
echo "Moved old dotfiles to ~/$TMPDIR"

# symlink dotfiles to the files in this repo
# -----------------------------------------------------
ln -sf ~/.dotfiles/git/config ~/.gitconfig
ln -sf ~/.dotfiles/python/pdbrc ~/.pdbrc
ln -sf ~/.dotfiles/python/condarc ~/.condarc
ln -sf ~/.dotfiles/vim/vimrc ~/.vimrc
mkdir -p ~/Library/KeyBindings
ln -sf ~/.dotfiles/macos/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict

# append to shell configs
# -----------------------------------------------------
# bash
BASH_LINE="source ~/.dotfiles/shell_setup/extra_bashrc"
if grep -q "$BASH_LINE" ~/.bash_profile; then
    echo "~/.bash_profile already sources from dotfiles. Skipped."
else
    echo "" >> ~/.bash_profile
    echo "# >>> dotfiles >>>" >> ~/.bash_profile
    echo "# !! Contents within this block are manged by ~/.dotfiles/install.sh" >> ~/.bash_profile
    echo "$BASH_LINE" >> ~/.bash_profile
    echo "# <<< dotfiles <<<" >> ~/.bash_profile
fi
# zsh
ZSH_LINE="source ~/.dotfiles/shell_setup/extra_zshrc"
if grep -q "$ZSH_LINE" ~/.zshrc; then
    echo "~/.zshrc already sources from dotfiles. Skipped."
else
    echo "" >> ~/.zshrc
    echo "# >>> dotfiles >>>" >> ~/.zshrc
    echo "# !! Contents within this block are manged by ~/.dotfiles/install.sh" >> ~/.zshrc
    echo "$ZSH_LINE" >> ~/.zshrc
    echo "# <<< dotfiles <<<" >> ~/.zshrc
fi

echo
echo "====== All Done!! ======"
echo
