#!/usr/bin/env fish
set -lx log_registry "Drop/Neovim"

# Dossier d'installation
set -l drop (path resolve .drops/nvim)
mkdir $drop; or exit 4

# Archive téléchargée directement
curl https://github.com/neovim/neovim-releases/releases/latest/download/nvim-linux-x86_64.tar.gz -sLo- \
    | tar xz -C $drop --strip-components=1

echo "#!/usr/bin/env fish
fish_add_path -ga $drop/bin" > ~/.config/fish/conf.d/1ext-20-nvim.fish
