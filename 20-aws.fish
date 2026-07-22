#!/usr/bin/env fish

# Dossier d'installation
set -l drop (path resolve .drops/aws)
mkdir $drop; or exit 4

# Téléchargement
curl -sL -o $drop/.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
unzip $drop/.zip -d $drop

# Auto-démarrage
echo "#!/usr/bin/env fish
fish_add_path -ga $drop/aws/dist" > ~/.config/fish/conf.d/1ext-20-aws.fish

