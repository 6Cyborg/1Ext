#!/bin/sh
# download-pkg.debian.sh — télécharge un paquet Debian et extrait ses .so
# Usage: ./download-pkg.debian.sh <paquet> <dossier_cible>

[ $# -ne 2 ] && exit 2

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

PKG=$1
DEST=$2

DL_PAGE="https://packages.debian.org/${VERSION_CODENAME}/${ARCH}/${PKG}/download"

echo "# Paquet: $PKG (suite=$VERSION_CODENAME, arch=$ARCH)" >&2
echo "# Page:   $DL_PAGE" >&2

# Premier miroir listé pour le .deb
DEB_URL=$(curl -sSL "$DL_PAGE" | tee /tmp/pkg-dl.${PKG}.html \
  | grep -oE 'https?://[^"]+/'"${PKG}"'_[^"]+\.deb' \
  | head -1)

[ -z "$DEB_URL" ] && { echo "Aucun .deb trouvé pour $PKG" >&2; exit 4; }

echo "# .deb:   $DEB_URL" >&2

WORK=$(mktemp -d)
trap 'rm -rf "$WORK"' EXIT

# Téléchargement + extraction (ar → data.tar.{xz,gz,zst} → contenu)
curl -sSL "$DEB_URL" -o "$WORK/pkg.deb"
( cd "$WORK" && ar x pkg.deb && tar xf data.tar.* )

mkdir -p "$DEST"

# Déplace tous les .so* trouvés (fichiers ET symlinks) en préservant les liens
find "$WORK" -name '*.so*' \( -type f -o -type l \) -exec mv -v {} "$DEST/" \;
