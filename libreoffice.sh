#!/bin/bash
APP="libreoffice"
VERSION=$1
RELEASE=${2:-"stable"}

ROOTDIR=$(pwd)
TMPDIR="${ROOTDIR}/${APP}.tmp"
WGETOPTIONS="--quiet --show-progress --progress=bar:force"
RSYNCOPTIONS="--links -r"

if [ $UID -ne 0 ]; then
	echo "sudo $0 <X.Y.Z> [testing]"
	exit 1
fi

if [ -z ${VERSION} ]; then
	echo "$0 <X.Y.Z> [testing]"
	exit 1
fi

echo "Installation de ${APP} ${VERSION}"

[ ! -d "${TMPDIR}" ] && mkdir -p "${TMPDIR}"

cd "${TMPDIR}"

wget ${WGETOPTIONS} https://download.documentfoundation.org/libreoffice/${RELEASE}/${VERSION}/deb/x86_64/LibreOffice_${VERSION}_Linux_x86-64_deb.tar.gz -O app.tgz
wget ${WGETOPTIONS} https://download.documentfoundation.org/libreoffice/${RELEASE}/${VERSION}/deb/x86_64/LibreOffice_${VERSION}_Linux_x86-64_deb_langpack_fr.tar.gz -O lang.tgz
wget ${WGETOPTIONS} https://download.documentfoundation.org/libreoffice/${RELEASE}/${VERSION}/deb/x86_64/LibreOffice_${VERSION}_Linux_x86-64_deb_helppack_fr.tar.gz -O help.tgz

[ -f app.tgz ] && [ -s app.tgz ]  && tar xzf app.tgz --strip 2
[ -f lang.tgz ]  && [ -s lang.tgz ] && tar xzf lang.tgz --strip 2
[ -f help.tgz ]  && [ -s help.tgz ] && tar xzf help.tgz --strip 2

dpkg -i *.deb

[ $? -eq 0 ] && rm -rf "${TMPDIR}"

exit $?
