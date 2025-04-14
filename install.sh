

# copy existing dotfiles to temporary directory
# -----------------------------------------------------
cd ~
TMPDIR=".tmp_dotfiles"
if [[ ! -e $TMPDIR ]]; then
    mkdir "$TMPDIR"
else [[ ! -d $TMPDIR ]]
    echo "$TMPDIR already exists. Clean up first!"
    exit 1
fi
mv ~/.gitconfig $TMPDIR/.gitconfig
echo "Moved old dotfiled to ~/$TMPDIR"

# symlink dotfiles to the files in this repo
ln -sf ~/.dotfiles/git/config ~/.gitconfig

echo
echo "====== All Done!! ======"
echo
