#!/bin/bash

for i in 81 82 83 84 85 86; do 
	echo "$i: `curl -s -k http://docker.marekexample.com:"$i" | head -1`" 
done
