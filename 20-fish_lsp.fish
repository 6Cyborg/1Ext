#!/usr/bin/env fish
set -lx log_registry "Drop/fish-lsp"

# Dossier d'installation
set -l drop (path resolve .drops/fish_lsp)
mkdir $drop; or exit 4

# Binaire téléchargé directement
mkdir $drop/bin
wget -qO $drop/bin/fish-lsp \
    https://github.com/ndonfris/fish-lsp/releases/latest/download/fish-lsp.standalone

chmod +x $drop/bin/fish-lsp

echo "#!/usr/bin/env fish
fish_add_path $drop/bin" > ~/.config/fish/conf.d/1ext-20-fish_lsp.fish

