#!/bin/bash
APP="Postman"
VERSION=${1:-"latest"}
INSTALLDIR=/opt/Postman

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

wget ${WGETOPTIONS} https://dl.pstmn.io/download/${VERSION}/linux64 -O app.tgz

[ -f app.tgz ] && [ -s app.tgz ] && tar xzf app.tgz

[ -d Postman ] && rsync ${RSYNCOPTIONS} Postman/ "${INSTALLDIR}" && rm -rf "${TMPDIR}"

exit $?
