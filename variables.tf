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

#variable "cluster_log_kms_key_id" {
#  description = "If a KMS Key ARN is set, this key will be used to encrypt the corresponding log group. Please be sure that the KMS Key has an appropriate key policy (https://docs.aws.amazon.com/AmazonCloudWatch/latest/logs/encrypt-log-data-kms.html)"
#  type        = string
#  default     = ""
#}

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

#variable "node_groups_defaults" {
#  description = "Map of values to be applied to all node groups. See `node_groups` module's documentation for more details"
#  type        = any
#  default     = {}
#}
#
#variable "node_groups" {
#  description = "Map of map of node groups to create. See `node_groups` module's documentation for more details"
#  type        = any
#  default     = {}
#}

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
      instance_types                            = ["t2.micro"]
      capacity_type= "ON_DEMAND"
    }
  ]
}
variable "eks_endpoint_private_access" {
  description = "Whether the Amazon EKS private API server endpoint is enabled. Default is false."
  type = bool
  default = false
}

variable "eks_endpoint_public_access" {
  description = "Whether the Amazon EKS public API server endpoint is enabled. Default is true."
  type = bool
  default = true
}

variable "eks_public_access_cidrs" {
  description = "List of CIDR blocks. Indicates which CIDR blocks can access the Amazon EKS public API server endpoint when enabled. EKS defaults this to a list with 0.0.0.0/0. in other words it will control from where we can invoke kubectl"
  type = list(string)
  default = ["0.0.0.0/0"]
}

#variable "enable_ingress_config" {
#  type = bool
#  default = true
#}


#endpoint_private_access = false
#    endpoint_public_access = true
#    public_access_cidrs     =var.cluster_en

#desired_capacity                     = var.workers_group_defaults["asg_desired_capacity"]
#      iam_role_arn                         = var.default_iam_role_arn
#      instance_types                       = [var.workers_group_defaults["instance_type"]]
#      key_name                             = var.workers_group_defaults["key_name"]
#      launch_template_id                   = var.workers_group_defaults["launch_template_id"]
#      launch_template_version              = var.workers_group_defaults["launch_template_version"]
#      set_instance_types_on_lt             = false
#      max_capacity                         = var.workers_group_defaults["asg_max_size"]
#      min_capacity                         = var.workers_group_defaults["asg_min_size"]
#      subnets                              = var.workers_group_defaults["subnets"]
#      create_launch_template               = false
#      bootstrap_env                        = {}
#      kubelet_extra_args                   = var.workers_group_defaults["kubelet_extra_args"]
#      disk_size                            = var.workers_group_defaults["root_volume_size"]
#      disk_type                            = var.workers_group_defaults["root_volume_type"]
#      disk_iops                            = var.workers_group_defaults["root_iops"]
#      disk_throughput                      = var.workers_group_defaults["root_volume_throughput"]
#      disk_encrypted                       = var.workers_group_defaults["root_encrypted"]
#      disk_kms_key_id                      = var.workers_group_defaults["root_kms_key_id"]
#      enable_monitoring                    = var.workers_group_defaults["enable_monitoring"]
#      eni_delete                           = var.workers_group_defaults["eni_delete"]
#      public_ip                            = var.workers_group_defaults["public_ip"]
#      pre_userdata                         = var.workers_group_defaults["pre_userdata"]
#      additional_security_group_ids        = var.workers_group_defaults["additional_security_group_ids"]
#      taints                               = []
#      timeouts                             = var.workers_group_defaults["timeouts"]
#      update_default_version               = true
#      ebs_optimized                        = null
#      metadata_http_endpoint               = var.workers_group_defaults["metadata_http_endpoint"]
#      metadata_http_tokens                 = var.workers_group_defaults["metadata_http_tokens"]
#      metadata_http_put_response_hop_limit = var.workers_group_defaults["metadata_http_put_response_hop_limit"]
#      ami_is_eks_optimized                 = true

variable "tag_for_cloud_watch_log_group" {
  type    = map(any)
  default = {}
}



#variable "encrypt_cloudwatch_logs_with_kms_key" {
#  description = "flag for encrypting cloud watch logs"
#  type        = bool
#  default     = true
#}

#variable "eks_version" {
#  default     = "1.12"
#  description = "define k8s version"
#}
#
#
#variable "image_id" {}
#
#
## variable "instance_ebs_optimized"{}
#variable "key_name" {}
#
## variable "launch_config_sec_group_id"{}
## variable "root_volume_size"{}
## we want ec2 instance must be created in private subnet
#variable "associate_public_ip_address" {
#  default = "false"
#}
#
#variable "desired_capacity" {}
#variable "min_size" {}
#variable "max_size" {}
#
#variable "inbound_cidr_rules_for_workstation_https" {
#}
#

#
#v
#
#variable "control_plane_logging_to_be_enabled" { default = [] }
#
#variable "worker_node_capacity_reservation_preference" {
#  default     = "none"
#  description = "possible values open or none. if open then reserved capacity used"
#}
#
#variable "worker_node_cpu_credits" {
#  default     = "standard"
#  description = "possible values standard or unlimited. T3 instances are launched as unlimited by default. T2 instances are launched as standard by default."
#}
#
#variable "worker_node_enable_detailed_monitoring" {
#  default     = "false"
#  description = "Possible values true or false. if it is true then detailed monitoring enabled for worker nodes"
#}
#
#variable "worker_node_ebs_optimized" {
#  default     = "false"
#  description = "Possible values true or false. if it is true then EBS will be optimized for worker node."
#}
#
#variable "worker_node_instance_types" {}
#
#variable "worker_node_on_demand_base_capacity" {
#  default = "0"
#}
#variable "worker_node_on_demand_percentage_above_base_capacity" {
#  default = "100"
#}
#
#variable "worker_node_spot_allocation_strategy" {
#  default     = "lowest-price"
#  description = "possible values capacity-optimized, lowest-price"
#}
#
#variable "worker_node_health_check_type" {
#  default     = "EC2"
#  description = "possible values EC2, ELB."
#}
#
#variable "worker_node_spot_instance_pools" {
#  default     = "2"
#  description = "Number of Spot pools per availability zone to allocate capacity. EC2 Auto Scaling selects the cheapest Spot pools and evenly allocates Spot capacity across the number of Spot pools that you specify."
#}
#
#variable "worker_node_spot_max_price" {
#  default     = ""
#  description = "Maximum price per unit hour that the user is willing to pay for the Spot instances. Default: an empty string which means the on-demand price"
#}
#
#variable "common_tags" {
#  type    = map
#  default = {}
#}
#
#variable "tag_for_worker_nodes" {
#  type    = map
#  default = {}
#}







