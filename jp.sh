#!/bin/bash

if [ $# -lt 2 ] ; then
    echo "jp.sh <port on server> <port n local>" 
    echo "example: sh jp.sh 8686 8989"
    echo "jp.sh <port on server> <port n local> <local ip> <user name>"
    echo "example: sh jp.sh 8686 8989 10.x.x.x username"
    exit 1
fi

if [ $# -ge 3 ]; then
   lip="$3"
else
   lip="10.x.x.x" #default IP of your choice
fi

if [ $# -ge 4 ]; then
   uid="$4"
else
   uid="username" #default username of your choice
fi

(cd ~ && jupyter notebook --no-browser --ip=0.0.0.0 --port="$1" > mylog 2>&1 &)
echo "jupuyter notebook started on server port $1"
echo "Port forwarding. $uid @ $lip server port:$1  local port:$2"
ssh -N -f -R "$2":localhost:"$1"  "$uid"@"$lip"
echo "open 'localhost:$2' in browser"
