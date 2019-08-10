# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7


DESCRIPTION="ShadowsocksR (SSR) native implementation for all platforms powered by libuv"
HOMEPAGE="https://github.com/ShadowsocksR-Live/shadowsocksr-native"
SRC_URI="https://github.com/ShadowsocksR-Live/shadowsocksr-native/releases/download/${PV}/ssr-native-linux-x64.zip -> ${P}.zip"
KEYWORDS="~amd64 ~x86"

LICENSE="GPL-3.0"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}"

src_install() {
	dobin ssr-{client,local,server} || die
}
