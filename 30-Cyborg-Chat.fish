#!/bin/sh
set -eu
drop="$(pwd)/.drops/Cyborg-Chat"

git clone https://github.com/6Cyborg/Cyborg-Chat.git "$drop"

ln -s "$drop/Cybc-Client/cybc-activate.fish" ~/.config/fish/conf.d/1ext-30-CyborgChat.fish

