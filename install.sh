#!/bin/bash

CUR_PATH=`pwd`

install_kms()
{
	echo "Install vlmcsd..."

	curl -o /tmp/vlmcsd.server https://github.com/xutl/ubnt-er-x/raw/master/kms/vlmcsd.server
	curl -o /tmp/vlmcsd https://github.com/xutl/ubnt-er-x/raw/master/kms/vlmcsd

	if [ -s /etc/init.d/vlmcsd ]; then
		rm -f /etc/init.d/vlmcsd
	fi

	if [ -s /usr/local/bin/vlmcsd ]; then
		rm -f /usr/local/bin/vlmcsd
	fi

	mv /tmp/vlmcsd.server /etc/init.d/vlmcsd
	mv /tmp/vlmcsd /config/bin/vlmcsd

	chmod +x /etc/init.d/vlmcsd
	chmod +x /config/bin/vlmcsd
	#chowm root:root /etc/init.d/vlmcsd
	#chowm root:root /usr/local/bin/vlmcsd
	insserv -v -d /etc/init.d/vlmcsd

	echo "Install Complete."
	echo "Starting Vlmcsd..."
	/etc/init.d/vlmcsd start
}

install_kms

exit 0