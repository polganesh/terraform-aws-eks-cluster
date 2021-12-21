#module "managed-node-group" {
#  source              = "./modules/managed-node-group"
#  count               = length(var.node_group_scaling_config)
#  cluster_name        = local.eks_cluster_name
#  cluster_endpoint    = aws_eks_cluster.main.endpoint
#  cluster_auth_base64 = aws_eks_cluster.main.certificate_authority[0].data
#  default_iam_role_arn = aws_iam_role.wnode.arn
#  managed_node_group_subnet_ids = data.aws_subnet_ids.private_app_subnets.ids
#
#  node_group_name = var.node_group_names[count.index]
#  node_group_scaling_config = {
#    desired_size = var.node_group_scaling_config[count.index].desired_capacity
#    max_size     = var.node_group_scaling_config[count.index].max_capacity
#    min_size     = var.node_group_scaling_config[count.index].min_capacity
#  }
#
#
#  #node_group = var.node_groups[count.index]
#  tags = merge(
#    var.common_tags,
#    var.tag_for_node_group,
#    local.generic_tags,
#    {
#      Name    = var.node_group_names[count.index]
#      AppRole = "compute"
#    }
#  )
#  depends_on = [
#    aws_eks_cluster.main,
#    aws_iam_role_policy_attachment.tf-eks-node-AmazonEKSWorkerNodePolicy,
#    aws_iam_role_policy_attachment.tf-eks-node-AmazonEKS_CNI_Policy,
#    aws_iam_role_policy_attachment.tf-eks-node-AmazonEC2ContainerRegistryReadOnly
#  ]
#}

module "managed-node-group" {
  source              = "./modules/managed-node-group"
  count               = length(var.node_groups)
  cluster_name        = local.eks_cluster_name
  cluster_endpoint    = aws_eks_cluster.main.endpoint
  cluster_auth_base64 = aws_eks_cluster.main.certificate_authority[0].data
  default_iam_role_arn = aws_iam_role.wnode.arn
  managed_node_group_subnet_ids = data.aws_subnet_ids.private_app_subnets.ids
  node_group = var.node_groups[count.index]
  tags = merge(
    var.common_tags,
    var.tag_for_node_group,
    local.generic_tags,
    {
      Name    = local.node_group_name
      AppRole = "compute"
    }
  )
  depends_on = [
    aws_eks_cluster.main,
    aws_iam_role_policy_attachment.tf-eks-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.tf-eks-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.tf-eks-node-AmazonEC2ContainerRegistryReadOnly,
    null_resource.tag-privateApp-subnet
  ]
}
