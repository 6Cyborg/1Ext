#!/usr/bin/env fish
set -lx log_registry "Drop/Cloudflared"

# Dossier d'installation
set -l drop (path resolve .drops/cloudflared)
mkdir $drop; or exit 4

# Binaire téléchargé directement
mkdir $drop/bin
wget -qO $drop/bin/cloudflared \
    https://github.com/cloudflare/cloudflared/releases/download/2026.5.2/cloudflared-linux-amd64

chmod +x $drop/bin/cloudflared

echo "#!/usr/bin/env fish
fish_add_path -ga $drop/bin" > ~/.config/fish/conf.d/1ext-20-cloudflared.fish

