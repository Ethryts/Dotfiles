
echo "copying files to ~/config/"
cp nvim ~/.config/ -r
echo "cloning packer to directory"
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
echo "launch nvim and run :PackerInstall"
