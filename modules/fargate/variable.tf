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

variable "fargate_profiles" {
  description = "Fargate profiles to create. "
  type        = any
  default     = {}
}

variable "subnets" {
  description = "A list of subnets for the EKS Fargate profiles."
  type        = list(string)
  default     = []
}

variable "cluster_name" {
  description = "Name of the EKS cluster."
  type        = string
  default     = ""
}


variable "permissions_boundary_for_fargate_role" {
  description = "If provided, all IAM roles will be created with this permissions boundary attached."
  type        = string
  default     = null
}
