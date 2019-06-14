#!/bin/bash
APP="Squirrel SQL"
VERSION=$1
INSTALLDIR=/opt/squirrel-sql

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

#wget ${WGETOPTIONS} https://sourceforge.net/projects/squirrel-sql/files/1-stable/${VERSION}-plainzip/squirrelsql-${VERSION}-optional.zip/download -O app.zip

[ -f app.zip ] && [ -s app.zip ]  && unzip -o app.zip

TMPAPPDIR="squirrelsql-${VERSION}-optional"
[ -d "${TMPAPPDIR}" ] && rsync ${RSYNCOPTIONS} "${TMPAPPDIR}/" "${INSTALLDIR}" && rm -rf "${TMPDIR}"

exit $?
