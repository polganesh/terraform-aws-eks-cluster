resource "aws_iam_role" "eks_fargate_pod" {
  name_prefix          = "rol-glob-${var.environment}-${var.cost_centre}-${var.app_service}eksfgt-${random_string.eks-fargate-iam-role-policy-suffix.result}-${var.seq_id}"
  assume_role_policy   = data.aws_iam_policy_document.eks_fargate_pod_assume_role.json
  permissions_boundary = var.permissions_boundary_for_fargate_role
  path                 = "/"
  #tags                 = var.tags
}

resource "aws_iam_role_policy_attachment" "eks_fargate_pod" {
  policy_arn = "arn:${data.aws_partition.current.partition}:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
  role       = aws_iam_role.eks_fargate_pod.name
}
