#!/bin/sh
set -eu
drop="$(pwd)/.drops/Cyborg-Web"

git clone https://github.com/6Cyborg/Cyborg-Web.git "$drop"

ln -s "$drop/Cybw-Client/cybc-activate.fish" ~/.config/fish/conf.d/1ext-30-CyborgWeb.fish

