variable "environment" {
  description = "indicates name of our environment. possible values dev,cit,sit,uat,pprod,prod,n"
  default     = "dev"
}

variable "cost_centre" {
  description = "A part of an organization to which costs may be charged.e.g. finance/it/hr/wholesale/retail/investment etc..."
  default     = "na"
}

variable "app_service" {}

variable "seq_id" {}

variable "region_id" {
  default = "euw1"
}

# useful if need to add tag
variable "region" {
  description = "region in which resource is created."
  default     = "eu-west-1"
}

variable "vpc_seq_id" {
}
variable "random_suffix_string" {}

variable "enable_ingress_config"{
  type = bool
  default = true
  description = "if true then it will created various roles policy for k8s cluster"
}

variable "aws_eks_cluster_name"{
  type = string
  default = ""
  description = "name of cluster to work on"
}



#variable "eks_cluster_details" {
#  type = object({
#    host= string
#
#  })
#}

#provider "kubernetes" {
##  host                   = data.aws_eks_cluster.cluster.endpoint
##  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
##  token                  = data.aws_eks_cluster_auth.cluster.token
##  load_config_file       = false
##  version                = "~> 1.10"
#  host= var.eks_cluster_endpoint
#  cluster_ca_certificate= base64decode(var_eks_cluster)
#}