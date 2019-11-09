#!/bin/sh
#set -e

# Prepend "tcpserver" if the first argument is not an executable
#if ! type -- "$1" &> /dev/null; then
#	set -- tcpserver "$@"
#fi

#exec "$@"

tcpserver 0 5678 echo "well done!!!!"
