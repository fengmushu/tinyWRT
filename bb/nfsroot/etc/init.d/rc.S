export PATH=/bin:/sbin:/usr/bin:/usr/sbin
export LD_LIBRARY_PATH=/lib:/usr/lib

/bin/hostname tinyWRT
USER="`id -un`"
LOGNAME=$USER
HOSTNAME='/bin/hostname'
PS1='[\u@\h \W]# '

mkdir /dev && cd /dev {
	mknod -m 666 console c 5 1
	mknod -m 666 null c 1 3
}
