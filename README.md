# Docker Containers

purpose of thise repository is to manage containers on docker.marekexample.com

# packer
image sizes:
- httpd:2.4 - 53MB
- httpd:2.4-alpine:3.15 - 17MB
- alpine:3.15 with apache apk - 9.3MB

prerequis
setup authentication to image registry in gitlab


# terraform


todo:
- curl displays different that index.html - add <p> 
- add outputs to file

# Important

Remember to reinitialize terraform, as .terraform directory is not kept in the repository (via .gitignore)


# Terraform environments

- live - uses modules to create resources
- stg - uses standard resource definitions
- dev - uses count and for_each methods. 
- dev2 - uses Terraform Cloud as a backend


# Features

- Packer images are stored in Gitlab repository
- null resource with local-exec is used for logging
