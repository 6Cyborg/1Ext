#!/usr/bin/env fish
set -lx log_registry "Drop/Mongosh"

# Dossier d'installation
set -l drop (path resolve .drops/mongosh)
mkdir $drop; or exit 4

tar x --strip-components=1 -C $drop \
    -f (curl -sLo- https://github.com/mongodb-js/mongosh/releases/download/v2.8.3/mongosh-2.8.3-linux-x64.tgz | psub)

test -f $drop/bin/mongosh; or exit 1

echo "#!/usr/bin/env fish
fish_add_path $drop/bin" > ~/.config/fish/conf.d/1ext-20-mongosh.fish

