output "vpc_id" {
  depends_on = [
    module.aws-vpc
  ]
  value = module.aws-vpc.vpc_id

}
output "vpc_name" {
  depends_on = [
    module.aws-vpc
  ]
  value = module.aws-vpc.vpc_name
}

output "public_subnet_ids" {
  depends_on = [
    module.pub_subnets
  ]
  value = module.pub_subnets.subnet_ids

}

output "worker_subnet_ids" {
  depends_on = [
    module.worker_subnets
  ]
  value = module.worker_subnets.subnet_ids
}

output "cluster_name" {
  value = module.cluster.name
  depends_on = [
    module.cluster
  ]
}

output "cluster_console_url" {
  value = module.cluster.console_url
  depends_on = [
    module.cluster
  ]
}

output "config_file_path" {
  value = module.cluster.config_file_path
  depends_on = [
    module.cluster
  ]
}


output "platform" {
  value = module.cluster.platform
}


output "domainname" {
  description = "The domain name  for the cluster"
  value = module.cluster.domainname
  depends_on  = [
    module.cluster
  ]
}
output "cluster_server_url" {
  value = module.cluster.server_url
}

output "cluster_username" {
  value = module.cluster.username
}

output "cluster_password" {
  value = module.cluster.password
  #sensitive = true
}
output "cluster_token" {
  value = module.cluster.token
  #sensitive = true
}

output "cluster_ingress" {
  value = module.cluster.platform.ingress
  sensitive = true
}
output "cluster_kubeconfig" {
  value = module.cluster.platform.kubeconfig
  sensitive = true
}
