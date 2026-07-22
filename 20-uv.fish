#!/usr/bin/env fish
set -lx log_registry "Drop/uv"

# Dossier d'installation
set -l drop (path resolve .drops/uv)
mkdir $drop; or exit 4
mkdir $drop/bin

# Archive téléchargée directement
curl https://releases.astral.sh/github/uv/releases/download/0.11.28/uv-x86_64-unknown-linux-gnu.tar.gz -Lso- \
    | tar xz -C $drop/bin --strip-components=1

echo "#!/usr/bin/env fish
fish_add_path -ga $drop/bin" > ~/.config/fish/conf.d/1ext-20-uv.fish
