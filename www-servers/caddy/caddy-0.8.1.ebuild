# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGO_PN=github.com/mholt/${PN}

inherit golang-base

SRC_URI="https://${EGO_PN}/archive/v${PVR}.tar.gz"

HOMEPAGE="https://caddyserver.com"
DESCRIPTION="Fast, cross-platform HTTP/2 web server with automatic HTTPS"

SLOT="0"
LICENSE="BSD"
KEYWORDS="amd64"
IUSE=""

DEPEND="${DEPEND}"
RDEPEND=""

src_compile() {
	debug-print-function ${FUNCNAME} "$@"

	ego_pn_check
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go get -d -v
	GOPATH="${WORKDIR}/${P}:$(get_golibdir_gopath)" \
		go build -v -work -x -o bin/${PN}
	echo "@"
	"$@" || die
}

src_install() {
	dobin ${PN}
}

