variable "cluster_name" {
  description = "Name of parent cluster"
  type        = string
  default     = ""
}

variable "cluster_endpoint" {
  description = "Endpoint of parent cluster"
  type        = string
  default     = ""
}

variable "cluster_auth_base64" {
  description = "Base64 encoded CA of parent cluster"
  type        = string
  default     = ""
}

variable "default_iam_role_arn" {
  description = "ARN of the default IAM worker role to use. "
  type        = string
  default     = ""
}

variable "workers_group_defaults" {
  description = "Workers group defaults from parent"
  type        = any
  default     = {}
}

variable "worker_security_group_id" {
  description = "If provided, all workers will be attached to this security group. If not given, a security group will be created with necessary ingress/egress to work with the EKS cluster."
  type        = string
  default     = ""
}

variable "worker_additional_security_group_ids" {
  description = "A list of additional security group ids to attach to worker instances"
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A map of tags to add to all resources"
  type        = map(string)
  default     = {}
}

variable "node_groups_defaults" {
  description = "map of maps of node groups to create. See \"`node_groups` and `node_groups_defaults` keys\" section in README.md for more details"
  type        = any
  default     = {}
}

variable "managed_node_group_subnet_ids" {
  type = set(string)
}

#---- node group
#variable "node_group_name" {
#  type    = string
#  default = "node-group"
#}
#
#variable "node_group_scaling_config" {
#  type        = any
#  default     = {}
#}

variable "node_group" {
  type = object({
    node_group_name                          = string
    scaling_config_desired_capacity          = number
    scaling_config_max_capacity              = number
    scaling_config_min_capacity              = number
    update_config_max_unavailable_percentage = number
    instance_types                           = list(string)
    capacity_type                            = string

  })
  default = {
    node_group_name                          = "ngrp1"
    scaling_config_desired_capacity          = 1
    scaling_config_max_capacity              = 1
    scaling_config_min_capacity              = 1
    update_config_max_unavailable_percentage = 50
    instance_types                           = ["t2.micro"]
    capacity_type                            = "ON_DEMAND"
  }
}

#variable "node_groups" {
#  description = "Map of maps of `eks_node_groups` to create. See \"`node_groups` and `node_groups_defaults` keys\" section in README.md for more details"
#  type        = any
#  default     = {}
#}
#
#variable "ebs_optimized_not_supported" {
#  description = "List of instance types that do not support EBS optimization"
#  type        = list(string)
#  default     = []
#}
#
