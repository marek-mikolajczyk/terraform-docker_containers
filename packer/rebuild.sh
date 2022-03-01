#!/bin/bash

CURRENT_DIR=$(pwd)

for i in `find . -name "httpd*" -type d`; do
	echo "=== Rebuilding $i ==="
	cd "$i"
	sh run.sh
	cd $CURRENT_DIR
done
