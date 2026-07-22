#!/bin/sh
set -eu
drop="$(pwd)/.drops/Cyborg-Web"

git clone https://github.com/6Cyborg/Cyborg-Web.git "$drop"

ln -s "$drop/Cybw-Cli/cybw-cli-activate.fish" ~/.config/fish/conf.d/1ext-30-CyborgWeb-Cli.fish

# TODO : Cybw-Local-Gologin utilise Chrome qui dépend de libs.
# trouve les manquantes via `ldd` puis lib/{filesearch,fileget}* les télécharge.

