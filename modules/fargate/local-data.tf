data "aws_partition" "current" {}

resource "random_string" "eks-fargate-iam-role-policy-suffix" {
  length  = 3
  special = false
}

locals {
    fargate_profiles = { for k, v in var.fargate_profiles : k => v  }
}

data "aws_iam_policy_document" "eks_fargate_pod_assume_role" {
  statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["eks-fargate-pods.amazonaws.com"]
    }
  }
}

#data "aws_iam_policy_document" "eks_fargate_pod_assume_role" {
#  count = local.create_eks && var.create_fargate_pod_execution_role ? 1 : 0
#
#  statement {
#    effect  = "Allow"
#    actions = ["sts:AssumeRole"]
#
#    principals {
#      type        = "Service"
#      identifiers = ["eks-fargate-pods.amazonaws.com"]
#    }
#  }
#}


