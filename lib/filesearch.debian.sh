#!/bin/sh
# debfind.sh — trouve les paquets Debian fournissant un fichier donné
# Usage: ./debfind.sh <nom_de_fichier>

[ $# -ne 1 ] && exit 2
. /etc/os-release || exit 3
[ -z "$VERSION_CODENAME" ] || [ "$NAME" != "Debian GNU/Linux" ] && exit 3

set -eu

# Mapping `uname -m` et Repo Debian :
case "$(uname -m)" in
    x86_64)  ARCH=amd64 ;;
    aarch64) ARCH=arm64 ;;
    armv7l)  ARCH=armhf ;;
    i686|i386) ARCH=i386 ;;
    riscv64) ARCH=riscv64 ;;
    ppc64le) ARCH=ppc64el ;;
    s390x)   ARCH=s390x ;;
    *) echo "Architecture inconnue: $(uname -m)" >&2; exit 2 ;;
esac

FILE=$1
URL="https://packages.debian.org/search?searchon=contents&keywords=${FILE}&mode=exactfilename&suite=${VERSION_CODENAME}&arch=${ARCH}"

echo "# Recherche: $FILE (suite=$VERSION_CODENAME, arch=$ARCH)" >&2
echo "# URL: $URL" >&2
echo >&2

curl -sSL "$URL" | tee /tmp/pkg-path.${FILE}.html |
    grep -oE "href=\"/${VERSION_CODENAME}/[a-z0-9][a-z0-9.+-]*\"" |
    sed -E "s|href=\"/${VERSION_CODENAME}/||" |
    sed -E 's|"$||' |
    sort -u
