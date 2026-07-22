#!/usr/bin/env fish
set -lx log_registry "Drop/OnlyOffice"

# Dossier d'installation
set -l drop (path resolve .drops/onlyoffice)
mkdir $drop; or exit 4

mkdir $drop/bin

wget -qO $drop/bin/OnlyOffice \
    https://github.com/ONLYOFFICE/DesktopEditors/releases/download/v9.4.0/DesktopEditors-x86_64.AppImage

chmod +x $drop/bin/OnlyOffice

echo "#!/usr/bin/env fish
fish_add_path -ga $drop/bin" > ~/.config/fish/conf.d/1ext-20-OnlyOffice.fish
