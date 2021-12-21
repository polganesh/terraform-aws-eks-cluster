resource "aws_eks_cluster" "main" {
  name                      = "eks-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id}"
  role_arn                  = aws_iam_role.main.arn
  version                   = var.eks_version
  enabled_cluster_log_types = var.control_plane_logging_to_be_enabled

  vpc_config {
    # refer local-data.tf for following.
    subnet_ids         = flatten([data.aws_subnet_ids.private_app_subnets.ids])
    security_group_ids = flatten([aws_security_group.tf-eks-master.id])
  }

  depends_on = [
    aws_iam_role_policy_attachment.eks-cluster-policy-attachment,
    aws_iam_role_policy_attachment.eks-service-policy-attachment,
    aws_cloudwatch_log_group.main
  ]
}