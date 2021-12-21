module "fargate" {
  source                                = "./modules/fargate"
  cluster_name                          = local.eks_cluster_name
  permissions_boundary_for_fargate_role = var.permissions_boundary_for_fargate_role
  subnets                               = var.fargate_subnets
  fargate_profiles                      = var.fargate_profiles
  seq_id                                = var.seq_id
  environment                           = var.environment
  cost_centre                           = var.cost_centre
  app_service                           = var.app_service

  depends_on = [aws_eks_cluster.main,null_resource.tag-privateApp-subnet]
}