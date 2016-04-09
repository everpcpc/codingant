# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
inherit user

DESCRIPTION="Real-time performance monitoring, done right!"
HOMEPAGE="http://netdata.firehol.org"
SRC_URI="https://github.com/firehol/netdata/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="sys-libs/zlib"
DEPEND="${RDEPEND}"

src_configure() {
	cd ${S}
	./autogen.sh || die
	econf --prefix="/usr" \
		  --sysconfdir="/etc" \
		  --localstatedir="/var" \
		  --with-zlib \
		  --with-math \
		  --with-user=netdata \
		  CGLAGS="$CFLAGS" || die "configure failed"
}

pkg_postinst() {
	enewgroup netdata
	enewuser netdata -1 /sbin/nologin -1 "netdata"

	# prepare the directories
	NETDATA_CACHE_DIR="/var/cache/netdata"
	NETDATA_WEB_DIR="/usr/share/netdata/web"
	NETDATA_LOG_DIR="/var/log/netdata"
	NETDATA_CONF_DIR="/etc/netdata"
	for x in "${NETDATA_WEB_DIR}" "${NETDATA_CONF_DIR}" "${NETDATA_CACHE_DIR}" "${NETDATA_LOG_DIR}"
	do
		if [ ! -d "${x}" ]
			then
			echo >&2 "Creating directory '${x}'"
			mkdir -p "${x}" || exit 1
			chown -R netdata:netdata "${x}"
			chmod 0775 "${x}"
		fi
	done

	# fix apps.plugin to be setuid to root
	chown root "${NETDATA_PREFIX}/usr/libexec/netdata/plugins.d/apps.plugin"
	chmod 4755 "${NETDATA_PREFIX}/usr/libexec/netdata/plugins.d/apps.plugin"

	# create an empty config if it does not exist
	[ ! -f "/etc/netdata/netdata.conf" ] && touch "/etc/netdata/netdata.conf"
}
