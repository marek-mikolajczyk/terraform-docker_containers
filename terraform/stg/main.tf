
######################################################################################################################################################## 
##### httpd1 #####
######################################################################################################################################################### 

data "docker_registry_image" "httpd1" {
  name = "gitlab-geo.marekexample.com:5050/docker/docker-containers/httpd1:latest"
}

resource "docker_image" "httpd1" {
  name          = data.docker_registry_image.httpd1.name
  pull_triggers = [data.docker_registry_image.httpd1.sha256_digest]
  force_remove  = true
}


resource "docker_container" "httpd1" {
  name  = "httpd1"
  image = docker_image.httpd1.latest

  env = []

  ports {
    internal = 80
    external = 81
  }

  provisioner "local-exec" {
    command = "./action.sh CREATE ${self.name}"
  }
  provisioner "local-exec" {
		when = destroy
    command = "./action.sh DESTROY ${self.name}"
  }

}


resource "null_resource" "test_httpd1" {
  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:81 | head -1"
  }
  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:81 | head -1  | tee -a action.log"
  }

  depends_on = [
    docker_container.httpd1,
  ]

    triggers = {
        docker_container_id = docker_container.httpd1.id
  }
}


######################################################################################################################################################### 


data "docker_registry_image" "httpd2" {
  name = "gitlab-geo.marekexample.com:5050/docker/docker-containers/httpd2:latest"
}


resource "docker_image" "httpd2" {
  name          = data.docker_registry_image.httpd2.name
  pull_triggers = [data.docker_registry_image.httpd2.sha256_digest]
  force_remove  = true
}


resource "docker_container" "httpd2" {
  name  = "httpd2"
  image = docker_image.httpd2.latest

  env = []

  ports {
    internal = 80
    external = 82
  }

  provisioner "local-exec" {
    command = "./action.sh CREATE ${self.name}"
  }
  provisioner "local-exec" {
		when = destroy
    command = "./action.sh DESTROY ${self.name}"
  }


}


resource "null_resource" "test_httpd2" {
  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:82 | head -1"
  }
  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:82 | head -1  | tee -a action.log"
  }


  depends_on = [
    docker_container.httpd2,
  ]

    triggers = {
        docker_container_id = docker_container.httpd2.id
  }
}
