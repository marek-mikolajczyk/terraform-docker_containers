#!/bin/bash

docker login gitlab-geo.marekexample.com:5050

docker build -t gitlab-geo.marekexample.com:5050/docker/docker-containers/httpd5 .

docker push gitlab-geo.marekexample.com:5050/docker/docker-containers/httpd5
