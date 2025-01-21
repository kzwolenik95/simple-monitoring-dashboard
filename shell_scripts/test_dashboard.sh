#!/usr/bin/env bash
set -e

re='^[0-9]+$'
if [ -z "$1" ] || ! [[ $1 =~ $re ]]
  then
    echo "Specify length of the load test in seconds"; exit 1
fi

proc_count=$(nproc)
mem_hoggers=$(free -m | awk '/Mem/ {printf "%.0f", $2/512}')
stress-ng --cpu "${proc_count}" --vm 2 --vm-bytes 512M --timeout $1