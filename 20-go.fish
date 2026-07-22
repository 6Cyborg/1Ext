#!/usr/bin/env fish
set -lx log_registry "Drop/Go"

# Dossiers d'installation
set -l goroot_dir (path resolve .drops/go)
set -l GOPATH (path resolve .drops/gopath)
mkdir $goroot_dir $GOPATH; or exit 4

llwait "Téléchargement de go"
tar xf (curl -sLo- https://go.dev/dl/go1.26.5.linux-amd64.tar.gz | psub) \
    -C $goroot_dir

set -l autoload ~/.config/fish/conf.d/1ext-20-go.fish
echo "#!/usr/bin/env fish
set -gx GOROOT '$goroot_dir/go'
set -gx GOPATH '$GOPATH'
fish_add_path -ga '$goroot_dir/go/bin'
fish_add_path -ga '$GOPATH/bin'" >$autoload
source $autoload

llwait "installing httpx"
go install github.com/projectdiscovery/httpx/cmd/httpx@latest

llwait "installing pup"
go install github.com/ericchiang/pup@latest

llwait "installing natscli"
go install github.com/nats-io/natscli/nats@latest
