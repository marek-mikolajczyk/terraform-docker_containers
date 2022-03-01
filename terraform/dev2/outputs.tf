output "docker_urls" {
  value = "${docker_container.httpd7-dev2["0"].name} : http://docker.marekexample.com:${docker_container.httpd7-dev2["0"].ports["0"].external}"
}