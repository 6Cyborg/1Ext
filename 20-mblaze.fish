#!/usr/bin/env fish
set -lx log_registry "Drop/Mblaze"

# Dossier d'installation
set -l drop (path resolve .drops/mblaze)
mkdir $drop; or exit 4

git clone https://github.com/leahneukirchen/mblaze $drop/repo
pushd $drop/repo
make all
make DESTDIR=$drop/root install
popd

chmod +x $drop/root/usr/local/bin/*

echo "#!/usr/bin/env fish
fish_add_path $drop/root/usr/local/bin
set -gxa MANPATH $drop/root/usr/local/share/man" > ~/.config/fish/conf.d/1ext-20-mblaze.fish

