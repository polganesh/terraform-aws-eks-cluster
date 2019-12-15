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

variable "eks_version" {
  default     = "1.12"
  description = "define k8s version"
}

variable "vpc_seq_id" {}
variable "image_id" {}


# variable "instance_ebs_optimized"{}
variable "key_name" {}

# variable "launch_config_sec_group_id"{}
# variable "root_volume_size"{}
# we want ec2 instance must be created in private subnet
variable "associate_public_ip_address" {
  default = "false"
}

variable "desired_capacity" {}
variable "min_size" {}
variable "max_size" {}

variable "inbound_cidr_rules_for_workstation_https" {
}

variable "version_id" { default = "1" }

variable "build_date" { default = "" }

variable "log_retention_in_days" { default = "5" }

variable "control_plane_logging_to_be_enabled" { default = [] }

variable "worker_node_capacity_reservation_preference" {
  default     = "none"
  description = "possible values open or none. if open then reserved capacity used"
}

variable "worker_node_cpu_credits" {
  default     = "standard"
  description = "possible values standard or unlimited. T3 instances are launched as unlimited by default. T2 instances are launched as standard by default."
}

variable "worker_node_enable_detailed_monitoring" {
  default     = "false"
  description = "Possible values true or false. if it is true then detailed monitoring enabled for worker nodes"
}

variable "worker_node_ebs_optimized" {
  default     = "false"
  description = "Possible values true or false. if it is true then EBS will be optimized for worker node."
}

variable "worker_node_instance_types" {}

variable "worker_node_on_demand_base_capacity" {
  default = "0"
}
variable "worker_node_on_demand_percentage_above_base_capacity" {
  default = "100"
}

variable "worker_node_spot_allocation_strategy" {
  default     = "capacity-optimized"
  description = "possible values capacity-optimized, lowest-price"
}

variable "worker_node_health_check_type" {
  default     = "EC2"
  description = "possible values EC2, ELB."
}

variable "worker_node_spot_instance_pools" {
  default     = "2"
  description = "Number of Spot pools per availability zone to allocate capacity. EC2 Auto Scaling selects the cheapest Spot pools and evenly allocates Spot capacity across the number of Spot pools that you specify."
}

variable "worker_node_spot_max_price" {
  default     = ""
  description = "Maximum price per unit hour that the user is willing to pay for the Spot instances. Default: an empty string which means the on-demand price"
}

variable "common_tags" {
  type    = map
  default = {}
}

variable "tag_for_worker_nodes" {
  type    = map
  default = {}
}







