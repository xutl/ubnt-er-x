#!/bin/bash

CUR_PATH=`pwd`

BASE_DIR=/config
BIN_DIR= ${BASE_DIR}/bin
ETC_DIR= ${BASE_DIR}/etc

init(){

	if [ ! -d "$BASE_DIR" ];then
		mkdir $BASE_DIR
	fi

	if [ ! -d "$BIN_DIR" ];then
		mkdir $BIN_DIR
	fi

	if [ ! -d "$ETC_DIR" ];then
		mkdir $ETC_DIR
	fi
}

install_kms()
{
	echo "Install vlmcsd..."

	curl -o /tmp/vlmcsd.server https://github.com/xutl/ubnt-er-x/raw/master/kms/vlmcsd.server
	curl -o /tmp/vlmcsd https://github.com/xutl/ubnt-er-x/raw/master/kms/vlmcsd

	if [ -s $ETC_DIR/init.d/vlmcsd ]; then
		rm -f $ETC_DIR/init.d/vlmcsd
	fi

	if [ -s $BIN_DIR/vlmcsd ]; then
		rm -f $BIN_DIR/vlmcsd
	fi

	mv /tmp/vlmcsd.server /etc/init.d/vlmcsd
	mv /tmp/vlmcsd $BIN_DIR/vlmcsd

	chmod +x /etc/init.d/vlmcsd
	chmod +x $BIN_DIR/vlmcsd
	#chowm root:root /etc/init.d/vlmcsd
	#chowm root:root /usr/local/bin/vlmcsd
	insserv -v -d $ETC_DIR/init.d/vlmcsd

	echo "Starting Vlmcsd..."
	/etc/init.d/vlmcsd start
}

init
install_kms

exit 0