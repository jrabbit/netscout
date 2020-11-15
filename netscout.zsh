#!/usr/bin/env zsh

function madison() {
	#wget -nc "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.23.tar.bz2"
	for pkg ("signify-openbsd" "gnupg2") 
		do newest=$(apt-cache madison $pkg | cut -d \| -f2 | xargs | cut -d " " -f 1)
		echo $newest
	done
}

function usc() {
	for pkg ("signify-openbsd" "gnupg2")
		do uscanout=$(cd $pkg && uscan 2> /dev/null) 
		echo $uscanout
	done
}

function add_pkg() {
	apt source $name
	ln -s $name*/ ./$name
}

usc
