#!/usr/bin/env zsh

PACKAGES=("signify-openbsd" "gnupg2")
DOWNLOADS_FOLDER=$PWD

function madison() {
	#wget -nc "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.23.tar.bz2"
	for pkg $PACKAGES 
		do newest=$(apt-cache madison $pkg | cut -d \| -f2 | xargs | cut -d " " -f 1)
		echo $newest
	done
}


function usc() {
	# check if diskspace
	avail=$(df --output=avail $PWD| tail -n1)
	if [[ $avail -gt 500000000 ]] # 500 MB 
	then
		for pkg $PACKAGES
			do uscanout=$(cd $pkg && uscan 2> /dev/null) 
			echo $uscanout
		done
	else
		echo "Error: out of space!!! bailing!!!"
	fi
}

function add_pkg(name) {
	apt source $name
	ln -s $name*/ ./$name
}


function download() {
	for pkg $PACKAGES
		do apt download $pkg
	done
}

usc
