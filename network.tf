data "ns_connection" "network" {
  name     = "network"
  contract = "network/gcp/vpc"
}

locals {
  vpc_access_connector = data.ns_connection.network.outputs.vpc_access_connector
}
