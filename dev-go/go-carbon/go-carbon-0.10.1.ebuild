# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/lomik/${PN}"

inherit golang-build golang-vcs-snapshot user

EGIT_COMMIT="v${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

DESCRIPTION="Golang implementation of Graphite/Carbon server with classic architecture: Agent -> Cache -> Persister"
HOMEPAGE="https://github.com/lomik/go-carbon"

SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0"
IUSE=""

src_compile() {
	cd src/${EGO_PN} || die
	GOPATH=${S} go get . || die
}

pkg_setup(){
	enewuser carbon
}

src_install() {
	dobin bin/*
	dodir /etc/${PN}
	insinto /etc/${PN}
	doins src/${EGO_PN}/deploy/*.conf
	dodoc src/${EGO_PN}/README.md

	dodir /var/lib/graphite/
	fowners -R carbon /var/lib/graphite/

	dodir /var/log/${PN}
	fowners -R carbon /var/log/${PN}
}
