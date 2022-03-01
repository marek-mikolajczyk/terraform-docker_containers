
data "docker_registry_image" "httpd7" {
  name = "gitlab-geo.marekexample.com:5050/docker/docker-containers/httpd7:latest"
}

resource "docker_image" "httpd7" {
  name          = data.docker_registry_image.httpd7.name
  pull_triggers = [data.docker_registry_image.httpd7.sha256_digest]
  force_remove  = true
}
########################################################################################################################################################
##### httpd-dev2 #####
#########################################################################################################################################################




resource "docker_container" "httpd7-dev2" {
        count = 1
  name  = "httpd7-dev2-${count.index}"
  image = docker_image.httpd7.latest

  env = []

  ports {
    internal = "80"
    external = "838${count.index}"
  }

  provisioner "local-exec" {
    command = "./action.sh CREATE ${self.name}"
  }
  provisioner "local-exec" {
                when = destroy
    command = "./action.sh DESTROY ${self.name}"
  }

}


resource "null_resource" "httpd7-dev2" {

        count = 1

  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:838${count.index}| head -1"
  }
  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:838${count.index} | head -1  | tee -a action.log"
  }


    triggers = {
        docker_container_id = "docker_container.httpd7-dev2-${count.index}.id"
  }
}


#########################################################################################################################################################
