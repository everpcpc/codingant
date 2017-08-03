# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

EGO_PN="github.com/go-graphite/${PN}"

inherit golang-build golang-vcs-snapshot

ARCHIVE_URI="https://${EGO_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="amd64"

DESCRIPTION="API server for github.com/go-graphite/carbonzipper"
HOMEPAGE="https://github.com/go-graphite/carbonapi"

SRC_URI="${ARCHIVE_URI}"
LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND="
	dev-go/dep
	dev-vcs/mercurial
"
RDEPEND=""

src_compile() {
	cd src/${EGO_PN}
	GOPATH=${S} dep ensure || die
	GOPATH=${S} go install -ldflags "-X main.BuildVersion=${PV}" || die
}

src_install() {
	dobin bin/*
	dodir /etc/${PN}
	insinto /etc/${PN}
	doins src/${EGO_PN}/carbonapi.example.yaml
	dodoc src/${EGO_PN}/README.md
}
