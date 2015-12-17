# Copyright 2015 awesome information technology, http://awesome-it.de
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Dependency Manager for PHP"
HOMEPAGE="https://getcomposer.org/"

EGIT_REPO_URI="https://github.com/composer/composer.git"
[[ ${PV} == "9999" ]] || EGIT_COMMIT="${PV/_alpha/-alpha}"
[[ ${PV} == "1.0.0_alpha11" ]] && EGIT_COMMIT="cd9054ce2abd1d06ed0eb1244eba1b2c2af633b6"

inherit git-2

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-lang/php"
RDEPEND="${DEPEND}"

src_prepare() {
	
	cd ${S}
	
    # Running PHP might create this
    addpredict /var/lib/net-snmp/mib_indexes	
	
	# Download recent composer for bootstraping
	curl -sS https://getcomposer.org/installer | php
	
	# Install dependencies to build composer
 	php composer.phar install
 	
 	# Enforce PHP settings to compile composer
	sed -s 's|<?php|<?php\nini_set("date.timezone", "UTC");|' -i "bin/compile" || die "Error setting default timezone."
	sed -s 's|#!/usr/bin/env php|#!/usr/bin/php -d phar.readonly=0|' -i "bin/compile" || die "Error enabling phar-archive creation."
 	
 	# Copmile composer
	einfo "Compiling composer.phar ..."
	rm composer.phar && ./bin/compile &>/dev/null || die "Error while (re-)compiling composer.phar"
	
	# Install
	mkdir "${WORKDIR}/${PF}"
	cp "composer.phar" "${WORKDIR}/${PF}/composer"
}

src_install() {
	into "/usr/local"
	dobin "composer"
}
