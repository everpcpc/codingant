# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/golang/${PN}"

inherit golang-build golang-vcs-snapshot

EGIT_COMMIT="v${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

DESCRIPTION="Go dependency management tool"
HOMEPAGE="https://github.com/golang/dep"

SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0"
IUSE=""

src_compile() {
	GOPATH=${S} go install ${EGO_PN}/cmd/dep || die
}

src_install() {
	dobin bin/*
	dodoc src/${EGO_PN}/README.md
}
