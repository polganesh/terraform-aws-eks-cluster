locals {
  eks_cluster_name = "eks-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id}"
  node_group_name  = "ngrp-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id}"
  vpc_name         = var.is_include_vpc_exact_match ? "vpc-${var.region_id}-${var.environment}-${var.cost_centre}-${var.vpc_seq_id}" : "vpc-${var.region_id}*-${var.cost_centre}-${var.vpc_seq_id}"
  log_group_name   = "/aws/eks/${local.eks_cluster_name}/cluster"
  generic_tags = {
    RegionId    = var.region_id
    Environment = var.environment
    CostCentre  = var.cost_centre
    VPCSeqId    = var.vpc_seq_id
    VersionId   = var.version_id
    BuildDate   = var.build_date
    AppService  = var.app_service
  }
  worker_groups_platforms        = [for x in concat(var.worker_groups, var.worker_groups_launch_template) : try(x.platform, var.workers_group_defaults["platform"], var.default_platform)]
  worker_ami_name_filter         = coalesce(var.worker_ami_name_filter, "amazon-eks-node-${coalesce(var.eks_version, "cluster_version")}-v*")
  worker_ami_name_filter_windows = coalesce(var.worker_ami_name_filter_windows, "Windows_Server-2019-English-Core-EKS_Optimized-${coalesce(var.eks_version, "cluster_version")}-*")

}

data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# get reference of aws VPC which contains name as value of <cost_centre>-<vpc_seq_id>
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = [local.vpc_name]
  }
}

# get reference of subnet which contains name as privApp
data "aws_subnet_ids" "private_app_subnets" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = "*-privApp-*"
  }
}

# get reference of subnet which contains name as -pub- in aws_vpc.vpc
data "aws_subnet_ids" "public_subnets" {
  vpc_id = data.aws_vpc.vpc.id

  tags = {
    Name = "*-pub-*"
  }
}


data "aws_ami" "eks_worker" {
  count = contains(local.worker_groups_platforms, "linux") ? 1 : 0

  filter {
    name   = "name"
    values = [local.worker_ami_name_filter]
  }

  most_recent = true

  owners = [var.worker_ami_owner_id]
}

data "aws_ami" "eks_worker_windows" {
  count = contains(local.worker_groups_platforms, "windows") ? 1 : 0

  filter {
    name   = "name"
    values = [local.worker_ami_name_filter_windows]
  }

  filter {
    name   = "platform"
    values = ["windows"]
  }

  most_recent = true

  owners = [var.worker_ami_owner_id_windows]
}

data "aws_eks_cluster" "cluster" {
  name = aws_eks_cluster.main.id
}

data "aws_eks_cluster_auth" "cluster" {
  name = aws_eks_cluster.main.id
}


resource "random_string" "eks-iam-role-policy-suffix" {
  length    = 3
  special   = false
  min_lower = 3
}
