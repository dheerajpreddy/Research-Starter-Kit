#!/bin/bash
if [ $# != 2 ]; then
echo "Usage: googledown.sh ID save_name"
exit 0
fi
confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id='$1 -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')
echo $confirm
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$confirm&id=$1" -O $2 && rm -rf /tmp/cookies.txt
