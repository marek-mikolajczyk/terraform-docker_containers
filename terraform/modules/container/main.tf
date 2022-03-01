######################################################################################################################################################### 
##### container #####
######################################################################################################################################################### 

data "docker_registry_image" "container_image_registry" {
    name = var.container_var_image_fqdn
  #name = "gitlab-geo.marekexample.com:5050/docker/docker-containers/httpd4:latest"
}


resource "docker_image" "container_image" {
  name          = data.docker_registry_image.container_image_registry.name
  pull_triggers = [data.docker_registry_image.container_image_registry.sha256_digest]
  force_remove  = true
}


resource "docker_container" "container_container" {
  name  = var.container_var_name
  image = docker_image.container_image.latest

  env = []

  ports {
    internal = var.container_var_port_internal
    external = var.container_var_port_external
  }


}


resource "null_resource" "container_curl" {
  provisioner "local-exec" {
    command = "curl --silent http://${var.container_var_docker_fqdn}:${var.container_var_port_external} | head -1"
  }

  depends_on = [
    docker_container.container_container,
  ]

    triggers = {
        docker_container_id = docker_container.container_container.id
  }
}
######################################################################################################################################################### 