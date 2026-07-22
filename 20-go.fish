#!/usr/bin/env fish
set -lx log_registry "Drop/Go"

# Dossiers d'installation
set -lx GOROOT (path resolve .drops/goroot)
set -lx GOPATH (path resolve .drops/gopath)
mkdir $GOROOT $GOPATH; or exit 4

llwait "Téléchargement de go"
tar xf (curl -sLo- https://go.dev/dl/go1.26.5.linux-amd64.tar.gz | psub) \
    -C $GOROOT --strip-components=1

alias go="$GOROOT/bin/go"
go install github.com/projectdiscovery/httpx/cmd/httpx@latest
go install github.com/ericchiang/pup@latest
go install github.com/nats-io/natscli/nats@latest

echo "#!/usr/bin/env fish
set -gx GOROOT '$GOROOT'
set -gx GOPATH '$GOPATH'
fish_add_path -ga '$GOROOT/bin'
fish_add_path -ga '$GOPATH/bin'" > ~/.config/fish/conf.d/1ext-20-go.fish
