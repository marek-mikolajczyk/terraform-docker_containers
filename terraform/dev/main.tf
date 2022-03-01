
data "docker_registry_image" "httpd1" {
  name = "gitlab-geo.marekexample.com:5050/docker/docker-containers/httpd1:latest"
}

resource "docker_image" "httpd1" {
  name          = data.docker_registry_image.httpd1.name
  pull_triggers = [data.docker_registry_image.httpd1.sha256_digest]
  force_remove  = true
}
########################################################################################################################################################
##### httpd-dev #####
#########################################################################################################################################################




resource "docker_container" "httpd-dev" {
        count = 2
  name  = "httpd1-dev-${count.index}"
  image = docker_image.httpd1.latest

  env = []

  ports {
    internal = "80"
    external = "818${count.index}"
  }

  provisioner "local-exec" {
    command = "./action.sh CREATE ${self.name}"
  }
  provisioner "local-exec" {
                when = destroy
    command = "./action.sh DESTROY ${self.name}"
  }

}


resource "null_resource" "httpd1-dev" {

        count = 2

  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:818${count.index}| head -1"
  }
  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:818${count.index} | head -1  | tee -a action.log"
  }

#  depends_on = [
#    "docker_container.httpd-dev-${count.index}",
#  ]

    triggers = {
        docker_container_id = "docker_container.httpd-dev-${count.index}.id"
  }
}


#########################################################################################################################################################


########################################################################################################################################################
##### httpd-tst #####
#########################################################################################################################################################




resource "docker_container" "httpd-tst" {
  for_each = toset( ["3", "4"] )
  name  = "httpd1-tst-${each.key}"
  image = docker_image.httpd1.latest

  env = []

  ports {
    internal = "80"
    external = "828${each.key}"
  }

  provisioner "local-exec" {
    command = "./action.sh CREATE ${each.key}"
  }
  provisioner "local-exec" {
                when = destroy
    command = "./action.sh DESTROY ${each.key}"
  }

}


resource "null_resource" "httpd1-tst" {

	for_each = toset( ["3", "4"] )

  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:818${each.key}| head -1"
  }
  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:818${each.key} | head -1  | tee -a action.log"
  }

#  depends_on = [
#    "docker_container.httpd-tst-${each.key}",
#  ]

    triggers = {
        docker_container_id = "docker_container.httpd-tst-${each.key}.id"
  }
}


#########################################################################################################################################################


########################################################################################################################################################
##### httpd-perf #####
#########################################################################################################################################################

variable "performance_count" {
    type = string
    description = "type small or big"
    default = "small"
}


resource "docker_container" "httpd-perf" {
  count = ( var.performance_count == "small" ? 1 : 5)
  name  = "httpd1-perf-${count.index}"
  image = docker_image.httpd1.latest

  env = []

  ports {
    internal = "80"
    external = "828${count.index}"
  }

  provisioner "local-exec" {
    command = "./action.sh CREATE ${self.name}"
  }
  provisioner "local-exec" {
                when = destroy
    command = "./action.sh DESTROY ${self.name}"
  }

}


resource "null_resource" "httpd1-perf" {

  count = ( var.performance_count == "small" ? 1 : 5)

  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:828${count.index}| head -1"
  }
  provisioner "local-exec" {
    command = "curl --silent http://docker.marekexample.com:828${count.index} | head -1  | tee -a action.log"
  }

#  depends_on = [
#    "docker_container.httpd-perf-${count.index}",
#  ]

    triggers = {
        docker_container_id = "docker_container.httpd-perf-${count.index}.id"
  }
}

