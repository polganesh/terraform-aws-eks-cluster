
#provider "kubernetes" {
#  host                   = data.aws_eks_cluster.cluster.endpoint
#  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority[0].data)
#  token                  = data.aws_eks_cluster_auth.cluster.token
#  #load_config_file       = false
#}
#
#module "ingress" {
#  source                = "./modules/ingress"
#  aws_eks_cluster_name  = local.eks_cluster_name
#  app_service           = var.app_service
#  random_suffix_string  = random_string.eks-iam-role-policy-suffix.result
#  seq_id                = var.seq_id
#  vpc_seq_id            = var.vpc_seq_id
#  cost_centre           = var.cost_centre
#  environment           = var.environment
#  region                = var.region
#  region_id             = var.region_id
#  enable_ingress_config = var.enable_ingress_config
#  depends_on            = [aws_eks_cluster.main,module.managed-node-group,module.fargate]
#}

