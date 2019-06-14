#!/bin/bash
APP="Insomnia"
VERSION=${1:-"latest"}

ROOTDIR=$(pwd)
TMPDIR="${ROOTDIR}/${APP}.tmp"
WGETOPTIONS="--quiet --show-progress --progress=bar:force"
RSYNCOPTIONS="--links -r"

if [ $UID -ne 0 ]; then
	echo "sudo $0 <latest>"
	exit 1
fi

if [ -z ${VERSION} ]; then
	echo "$0 <latest>"
	exit 1
fi

echo "Installation de ${APP} ${VERSION}"

[ ! -d "${TMPDIR}" ] && mkdir -p "${TMPDIR}"

cd "${TMPDIR}"

wget ${WGETOPTIONS} https://updates.insomnia.rest/downloads/ubuntu/${VERSION} -O app.deb

[ -f app.deb ] && [ -s app.deb ]  && dpkg -i app.deb

[ $? -eq 0 ] && rm -rf "${TMPDIR}"

exit $?
