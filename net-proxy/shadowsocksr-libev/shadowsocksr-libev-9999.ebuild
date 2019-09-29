# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit git-r3

DESCRIPTION="ShadowsocksR (SSR) native implementation with libev"
HOMEPAGE="https://github.com/shadowsocksr-backup/shadowsocksr-libev"

EGIT_REPO_URI="https://github.com/shadowsocksr-backup/shadowsocksr-libev"

LICENSE="GPL-3.0"
SLOT="0"
IUSE=""
KEYWORDS="~amd64"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	app-text/asciidoc
	app-text/xmlto
	dev-libs/openssl
	dev-libs/libpcre
"

CFLAGS="${CFLAGS} -Wno-error=format-overflow -Wno-error=sizeof-pointer-memaccess"

src_install() {
	newbin src/ss-local ssr-local
	newbin src/ss-nat ssr-nat
	newbin src/ss-redir ssr-redir
}
