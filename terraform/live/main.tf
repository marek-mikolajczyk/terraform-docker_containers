######################################################################################################################################################### 
##### httpd3 #####
######################################################################################################################################################### 

data "docker_registry_image" "httpd3" {
  name = "gitlab-geo.marekexample.com:5050/docker/docker-containers/httpd3:latest"
}


resource "docker_image" "httpd3" {
  name          = data.docker_registry_image.httpd3.name
  pull_triggers = [data.docker_registry_image.httpd3.sha256_digest]
  force_remove  = true
}


resource "docker_container" "httpd3" {
  name  = "httpd3"
  image = docker_image.httpd3.latest

  env = []

  ports {
    internal = 80
    external = 83
  }


}


resource "null_resource" "test_httpd3" {
  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:83 | head -1"
  }

  depends_on = [
    docker_container.httpd3,
  ]

    triggers = {
        docker_container_id = docker_container.httpd3.id
  }
}
######################################################################################################################################################### 


######################################################################################################################################################### 
##### httpd4 #####
######################################################################################################################################################### 

data "docker_registry_image" "httpd4" {
  name = "gitlab-geo.marekexample.com:5050/docker/docker-containers/httpd4:latest"
}


resource "docker_image" "httpd4" {
  name          = data.docker_registry_image.httpd4.name
  pull_triggers = [data.docker_registry_image.httpd4.sha256_digest]
  force_remove  = true
}


resource "docker_container" "httpd4" {
  name  = "httpd4"
  image = docker_image.httpd4.latest

  env = []

  ports {
    internal = 80
    external = 84
  }


}


resource "null_resource" "test_httpd4" {
  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:84 | head -1"
  }

  depends_on = [
    docker_container.httpd4,
  ]

    triggers = {
        docker_container_id = docker_container.httpd4.id
  }
}
######################################################################################################################################################### 



######################################################################################################################################################### 
##### httpd5 #####
#########################################################################################################################################################

module "httpd5" {
    source  = "../modules/container/"

    container_var_image_fqdn = "gitlab-geo.marekexample.com:5050/docker/docker-containers/httpd5:latest"
    container_var_name = "httpd5"
    container_var_port_internal = 80
    container_var_port_external = 85
    container_var_docker_fqdn = "docker.marekexample.com"

}
