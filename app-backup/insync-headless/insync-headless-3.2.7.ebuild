# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

DESCRIPTION="Advanced cross-platform Google Drive headless client"
HOMEPAGE="https://www.insynchq.com/"

MAGIC="10758"
MAIN_INSTALLER_STRING="https://cdn.insynchq.com/builds/linux/insync-headless_${PV}.${MAGIC}-buster"

SRC_URI="
	amd64?    ( ${MAIN_INSTALLER_STRING}_amd64.deb ) -> ${P}.deb"

LICENSE="as-is"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/lib64.patch"
)

src_unpack() {
	mkdir -p "${S}"
	unpack_deb "${DISTDIR}/${P}.deb"
	mv "${WORKDIR}/usr" "${S}/"
}

src_install() {
	cp -pPR "${WORKDIR}"/"${P}"/usr/ "${D}"/ || die "Installation failed"
	mv "${D}"/usr/lib "${D}"/usr/lib64
	rm -Rf "${D}"/usr/lib64/.build-id
	gunzip "${D}"/usr/share/man/man1/insync-headless.1.gz
	gunzip "${D}"/usr/share/man/man1/insync-headless-*.1.gz

	dosym /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt

	echo "SEARCH_DIRS_MASK=\"/usr/lib*/insync\"" > "${T}/70-${PN}" || die
	insinto "/etc/revdep-rebuild" && doins "${T}/70-${PN}" || die
}

