#!/bin/sh

logpath=$1

if [ ! -n "$logpath" ]; then
    echo "chmod log permision failed"
else
    chown -R zceo:zceo "$logpath"
fi
