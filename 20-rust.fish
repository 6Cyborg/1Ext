#!/usr/bin/env fish
set -lx log_registry 1ExtDropper/Rust

# Dossier d'installation
set -l drop (path resolve .drops/rust)
mkdir $drop; or exit 4

# Téléchargement de l'installateur
curl -sLo $drop/rustup-init.sh \
    https://raw.githubusercontent.com/rust-lang/rustup/refs/heads/main/rustup-init.sh
or exit (lerr -e1 "Download rustup-init.sh has failed")

set -lx RUSTUP_HOME $drop/rustup
set -lx CARGO_HOME $drop/cargo

llwait "installing rust"
sh $drop/rustup-init.sh \
    --no-modify-path \
    --default-toolchain nightly \
    --profile default \
    -y -q
or exit (lerr -e1 "rustup-init has failed")

set -l autoload ~/.config/fish/conf.d/1ext-20-rust.fish

echo "#!/usr/bin/env fish
set -gx RUSTUP_HOME '$RUSTUP_HOME'
set -gx CARGO_HOME '$CARGO_HOME'
fish_add_path -ga '$CARGO_HOME/bin'
source '$CARGO_HOME/env.fish'" >$autoload

source $autoload

llwait "Installations des binaires externes"
cargo install toml2json
cargo install websocat

