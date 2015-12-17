# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils qt5-build

DESCRIPTION="GUI to access Czech eGov \"Datove schranky\""
HOMEPAGE="https://labs.nic.cz/cs/datovka.html"
SRC_URI="https://secure.nic.cz/files/datove_schranky/${PV}/${P}-src.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	net-libs/libisds
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsql:5[sqlite]
	dev-libs/openssl
"
RDEPEND="${DEPEND}"

src_unpack() {
    default
    mv ${WORKDIR}/${P} ${WORKDIR}/${PN}-opensource-src-${PV}
}
