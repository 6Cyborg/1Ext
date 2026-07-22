#!/usr/bin/env fish
set -lx log_registry "Drop/CurlImpersonate"

# Dossier d'installation
set -l drop (path resolve .drops/curl_impersonate)
mkdir $drop; or exit 4

# Binaire téléchargé directement
mkdir $drop/bin
tar x -C $drop/bin -f \
    (curl -Lo- https://github.com/lwthiker/curl-impersonate/releases/download/v0.6.1/curl-impersonate-v0.6.1.x86_64-linux-gnu.tar.gz | psub)

chmod +x $drop/bin/*

echo "#!/usr/bin/env fish
fish_add_path -ga $drop/bin" > ~/.config/fish/conf.d/1ext-20-curl_impersonate.fish

