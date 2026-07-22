#!/bin/sh
mkdir -p .drops/fish
export drop=$(readlink -f .drops/fish)

echo "export PATH=\$PATH:$drop" >>~/.bashrc

# Téléchargement
curl https://github.com/fish-shell/fish-shell/releases/download/4.8.0/fish-4.8.0-linux-x86_64.tar.xz -sLo- |
    tar xJ -C $drop

# shell tmux
echo "# Génération automatiquement
set-option -g default-shell '$drop/fish';
set-option -g default-command '$drop/fish';
set-option -g history-limit 50000;" >~/.tmux.conf

# shell ssh (en tout dernier!)
echo '[[ $- == *i* ]] && [[ -z "$OKFISH" ]] && export OKFISH=1 && exec fish' >>~/.bashrc

