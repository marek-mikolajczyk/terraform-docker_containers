output "docker_urls" {
  value = "${docker_container.httpd-tst["3"].name} : http://docker.marekexample.com:${docker_container.httpd-tst["3"].ports["0"].external}"
}

output "docker_urls-perf" {
  value = "Number of perf container: ${var.performance_count}"
}
