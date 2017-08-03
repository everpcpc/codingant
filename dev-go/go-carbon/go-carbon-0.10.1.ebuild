# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/lomik/${PN}"

inherit golang-build golang-vcs-snapshot

EGIT_COMMIT="v${PV}"
ARCHIVE_URI="https://${EGO_PN}/archive/${EGIT_COMMIT}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

DESCRIPTION="Golang implementation of Graphite/Carbon server with classic architecture: Agent -> Cache -> Persister"
HOMEPAGE="https://github.com/lomik/go-carbon"

SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0"
IUSE=""

src_install() {
	dobin bin/*
	dodoc src/${EGO_PN}/README.md
}
