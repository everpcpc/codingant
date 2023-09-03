# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd rpm

DESCRIPTION="HPE Agentless Management Service (Gen9 and earlier)"
HOMEPAGE="https://support.hpe.com/connect/s/softwaredetails?softwareId=MTX_f352c7ceaea841829afdd65f22"
SRC_URI="https://downloads.hpe.com/pub/softlib2/software1/pubsw-linux/p904411522/v206680/hp-ams-2.10.5-888.3.rhel7.x86_64.rpm"

LICENSE="hpe"
SLOT="0"
KEYWORDS="amd64"
RESTRICT="mirror"

S="${WORKDIR}"

RDEPEND="
	app-arch/rpm
	dev-libs/libnl:3
"

src_unpack() {
	rpm_unpack
}

src_prepare() {
	default
	# We use dosbin in src_install to install the amsHelper, which
	# will install the helper binary in /usr/sbin, not /sbin.
	sed -i 's;ExecStart=/sbin/amsHelper;ExecStart=/usr/sbin/amsHelper;' \
		usr/lib/systemd/system/hp-ams.service
}

src_install() {
	dosbin sbin/amsHelper

	insinto /etc/sysconfig
	doins etc/sysconfig/hp-ams

	systemd_dounit usr/lib/systemd/system/hp-ams.service

	readonly amsHelperManPage="usr/share/man/man8/amsHelper.8"
	gunzip "${amsHelperManPage}".gz
	doman "${amsHelperManPage}"

	dodoc opt/hp/hp-ams/hp-ams.license
}

