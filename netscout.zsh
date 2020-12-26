#!/usr/bin/env zsh

PACKAGES=("signify-openbsd" "gnupg2")
DOWNLOADS_FOLDER=$PWD

madison() {
	#wget -nc "https://gnupg.org/ftp/gcrypt/gnupg/gnupg-2.2.23.tar.bz2"
	for pkg in $PACKAGES
		do newest=$(apt-cache madison $pkg | cut -d \| -f2 | xargs | cut -d " " -f 1)
		echo $newest
		done
}


usc() {
	# check if diskspace
	avail=$(df --output=avail $PWD| tail -n1)
	if [[ $avail -gt 500000000 ]] # 500 MB 
	then
		for pkg in $PACKAGES
			#  uscan --package gnupg --upstream-version 0.0.0 --watchfile gnupg2-2.2.20/debian/watch
			do uscanout=$(mkdir -p $pkg && chmod 777 ./$pkg && cd $pkg && apt source $pkg && apt download $pkg && uscan --package $pkg --upstream-version 0.0.0 --watchfile $pkg/$pkg-*/debian/watch 2> /dev/null) 
			echo $uscanout
		done
	else
		echo "Error: out of space!!! bailing!!!"
	fi
}

# add_pkg(name) {
	# apt source $name
	# ln -s $name*/ ./$name
# }

download() {
	for pkg in $PACKAGES
		do apt download $pkg
	done
}

usc
