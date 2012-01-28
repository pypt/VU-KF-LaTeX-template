#!/bin/sh

if [ ! $1 ]; then
    echo "Usage: $0 document.tex"
    exit 1
fi

echo "Word count:" `detex $1 | wc -w`
echo "Symbol count:" `detex $1 | wc -m`
