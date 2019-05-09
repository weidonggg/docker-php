#! /bin/bash

logpath=$1

if [ ! -n "$logpath" ]; then
    echo "chmod log permision failed"
else
    gosu root chown -R zceo:zceo "$logpath"
fi
