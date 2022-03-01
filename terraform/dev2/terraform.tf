terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker",
      version = "2.16.0"
    }
  }

  cloud {
    organization = "example-org-e95f05"
    workspaces {
      name = "terraform-docker_containers"
    }
  }

  required_version = ">= 0.13, <= 2.0"
}

provider "docker" {
  host = "tcp://192.168.0.45:2375"
  registry_auth {
    address  = "gitlab-geo.marekexample.com:5050"
    username = "root"
    password = "haslo123"
  }
}
