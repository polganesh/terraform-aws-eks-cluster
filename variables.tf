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

variable "version_id" {
  default = "001"
}

variable "build_date" {
  default = ""
}

variable "is_include_vpc_exact_match" {
  default = false
}

variable "log_retention_in_days" {
  default     = "90"
  description = "Specifies the number of days you want to retain log events in the specified log group."
}

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logging to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html). possible values in list api, authenticator, controllerManager, scheduler"
  type        = list(string)
  default     = []
}

variable "eks_version" {
  default     = "1.19"
  description = "define k8s version"
}

variable "cluster_egress_cidrs" {
  description = "List of CIDR blocks that are permitted for cluster egress traffic."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "cluster_service_ipv4_cidr" {
  description = "service ipv4 cidr for the kubernetes cluster. for more info refer https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster#kubernetes_network_config"
  type        = string
  default     = null
}

variable "cluster_encryption_config" {
  description = "Configuration block with encryption configuration for the cluster. for more info https://aws.amazon.com/blogs/containers/using-eks-encryption-provider-support-for-defense-in-depth/"
  type = list(object({
    provider_key_arn = string
    resources        = list(string)
  }))
  default = []
}

variable "common_tags" {
  type    = map(any)
  default = {}
}

variable "tag_for_eks" {
  type    = map(any)
  default = {}
}

variable "tag_for_iam" {
  type    = map(any)
  default = {}
}

variable "timeout_for_resource_creation" {
  default = "50m"
}

variable "timeout_for_resource_delete" {
  default = "50m"
}

variable "timeout_for_resource_update" {
  default = "50m"
}

variable "manage_cluster_iam_resources" {
  description = "Whether to let the module manage cluster IAM resources. If set to false, cluster_iam_role_name must be specified."
  type        = bool
  default     = true
}

variable "manage_worker_iam_resources" {
  description = "Whether to let the module manage worker IAM resources. If set to false, iam_instance_profile_name must be specified for workers."
  type        = bool
  default     = true
}

variable "permissions_boundary_for_fargate_role" {
  description = "If provided, fargate IAM roles will be created with this permissions boundary attached."
  type        = string
  default     = null
}

variable "fargate_subnets" {
  description = "A list of subnets to place fargate workers within (if different from subnets)."
  type        = list(string)
  default     = []
}

variable "fargate_profiles" {
  description = "Fargate profiles to create. "
  type        = any
  default     = {}
}

variable "workers_group_defaults" {
  description = "Override default values for target groups. See workers_group_defaults_defaults in local.tf for valid keys."
  type        = any
  default     = {}
}

variable "default_platform" {
  description = "Default platform name. Valid options are `linux` and `windows`."
  type        = string
  default     = "linux"
}

variable "worker_groups" {
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Configurations. See workers_group_defaults for valid keys."
  type        = any
  default     = []
}

variable "worker_groups_launch_template" {
  description = "A list of maps defining worker group configurations to be defined using AWS Launch Templates. See workers_group_defaults for valid keys."
  type        = any
  default     = []
}

variable "worker_ami_name_filter" {
  description = "Name filter for AWS EKS worker AMI. If not provided, the latest official AMI for the specified 'cluster_version' is used."
  type        = string
  default     = ""
}

variable "worker_ami_name_filter_windows" {
  description = "Name filter for AWS EKS Windows worker AMI. If not provided, the latest official AMI for the specified 'cluster_version' is used."
  type        = string
  default     = ""
}

variable "worker_ami_owner_id" {
  description = "The ID of the owner for the AMI to use for the AWS EKS workers. Valid values are an AWS account ID, 'self' (the current account), or an AWS owner alias (e.g. 'amazon', 'aws-marketplace', 'microsoft')."
  type        = string
  default     = "amazon"
}

variable "worker_ami_owner_id_windows" {
  description = "The ID of the owner for the AMI to use for the AWS EKS Windows workers. Valid values are an AWS account ID, 'self' (the current account), or an AWS owner alias (e.g. 'amazon', 'aws-marketplace', 'microsoft')."
  type        = string
  default     = "amazon"
}

variable "worker_additional_security_group_ids" {
  description = "A list of additional security group ids to attach to worker instances"
  type        = list(string)
  default     = []
}

variable "tag_for_node_group" {
  type    = map(any)
  default = {}
}

variable "node_group_names" {
  type    = list(string)
  default = []
}
variable "node_group_scaling_config" {
  type    = list(any)
  default = []

}

variable "node_groups" {
  type = list(object({
    node_group_name                          = string
    scaling_config_desired_capacity          = number
    scaling_config_max_capacity              = number
    scaling_config_min_capacity              = number
    update_config_max_unavailable_percentage = number
    instance_types                           = list(string)
    capacity_type                            = string
  }))
  default = [
    {
      node_group_name                          = "ngrp1"
      scaling_config_desired_capacity          = 1
      scaling_config_max_capacity              = 1
      scaling_config_min_capacity              = 1
      update_config_max_unavailable_percentage = 50
      instance_types                           = ["t2.micro"]
      capacity_type                            = "ON_DEMAND"
    }
  ]
}
variable "eks_endpoint_private_access" {
  description = "Whether the Amazon EKS private API server endpoint is enabled. Default is false."
  type        = bool
  default     = false
}

variable "eks_endpoint_public_access" {
  description = "Whether the Amazon EKS public API server endpoint is enabled. Default is true."
  type        = bool
  default     = true
}

variable "eks_public_access_cidrs" {
  description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0. in other words it will control from where we can invoke kubectl"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "tag_for_cloud_watch_log_group" {
  type    = map(any)
  default = {}
}

variable "enable_irsa" {
  type        = bool
  default     = false
  description = "enable IAM role for Service account "
}

variable "openid_connect_audiences" {
  description = "List of OpenID Connect audience client IDs to add to the IRSA provider"
  type        = list(string)
  default     = []
}

#variable "lifecycle_prevent_destroy" {
#  type = bool
#  default = false
#}

variable "cluster_addons" {
  description = "Map of cluster addon configurations to enable for the cluster. Addon name can be the map keys or set with `name`"
  type        = any
  default     = {}
}
