#!/bin/bash
APP="DBeaver"
VERSION=${1:-"latest"}
INSTALLDIR=/opt/dbeaver

ROOTDIR=$(pwd)
TMPDIR="${ROOTDIR}/${APP}.tmp"
WGETOPTIONS="--quiet --show-progress --progress=bar:force"
RSYNCOPTIONS="--links -r"

if [ $UID -ne 0 ]; then
	echo "sudo $0 [version]"
	exit 1
fi

if [ -z ${VERSION} ]; then
	echo "$0 [version]"
	exit 1
fi

echo "Installation de ${APP} ${VERSION}"

[ ! -d "${INSTALLDIR}" ] && mkdir -p "${INSTALLDIR}"
[ ! -d "${TMPDIR}" ] && mkdir -p "${TMPDIR}"

cd "${TMPDIR}"

wget ${WGETOPTIONS} https://dbeaver.io/files/dbeaver-ce-${VERSION}-linux.gtk.x86_64.tar.gz -O app.tgz

[ -f app.tgz ] && [ -s app.tgz ]  && tar xzf app.tgz

[ -d dbeaver ] && rsync ${RSYNCOPTIONS} dbeaver/ "${INSTALLDIR}" && rm -rf "${TMPDIR}"

exit $?
