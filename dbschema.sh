#!/bin/bash
APP="DbSchema"
VERSION=$1
FIXVERSION=$(echo $VERSION | sed 's/\./\_/g')
INSTALLDIR=/opt/DbSchema

ROOTDIR=$(pwd)
TMPDIR="${ROOTDIR}/${APP}.tmp"
WGETOPTIONS="--quiet --show-progress --progress=bar:force"
RSYNCOPTIONS="--links -r"

if [ $UID -ne 0 ]; then
	echo "sudo $0 <X.Y.Z>"
	exit 1
fi

if [ -z ${VERSION} ]; then
	echo "$0 <X.Y.Z>"
	exit 1
fi

echo "Installation de ${APP} ${VERSION}"

[ ! -d "${INSTALLDIR}" ] && mkdir -p "${INSTALLDIR}"
[ ! -d "${TMPDIR}" ] && mkdir -p "${TMPDIR}"

cd "${TMPDIR}"

wget ${WGETOPTIONS} https://www.dbschema.com/download/DbSchema_unix_${FIXVERSION}.tar.gz -O app.tgz

[ -f app.tgz ] && [ -s app.tgz ] && tar xzf app.tgz

[ -d DbSchema ] && rsync ${RSYNCOPTIONS} DbSchema/ "${INSTALLDIR}" && rm -rf "${TMPDIR}"

exit $?
