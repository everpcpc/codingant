# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils

DESCRIPTION="Building blocks for developing proxy servers in golang."
HOMEPAGE="https://www.v2ray.com"
SRC_URI="https://github.com/v2ray/v2ray-core/releases/download/v${PV}/v2ray-linux-64.zip -> ${P}.zip"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin v2ray
	dodir /etc/v2ray
}
