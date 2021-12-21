resource "aws_eks_cluster" "main" {
  name                      = local.eks_cluster_name
  version                   = var.eks_version
  enabled_cluster_log_types = var.cluster_enabled_log_types
  role_arn                  = aws_iam_role.eks-role.arn
  vpc_config {
    subnet_ids         = flatten([data.aws_subnet_ids.private_app_subnets.ids])
    security_group_ids = flatten([aws_security_group.tf-eks-master.id])
    # following mainly control how kubectl can work with this eks
    endpoint_private_access = var.eks_endpoint_private_access
    endpoint_public_access = var.eks_endpoint_public_access
    public_access_cidrs     =var.eks_public_access_cidrs
  }

  kubernetes_network_config {
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }
  # for more info refer
  #https://aws.amazon.com/blogs/containers/using-eks-encryption-provider-support-for-defense-in-depth/
  # https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster#kubernetes_network_config refer encryption config
  dynamic "encryption_config" {
    for_each = toset(var.cluster_encryption_config)
    content {
      provider {
        key_arn = encryption_config.value["provider_key_arn"]
      }
      resources = encryption_config.value["resources"]
    }
  }

  tags = merge(
    var.common_tags,
    var.tag_for_eks,
    local.generic_tags,
    {
      Name    = local.eks_cluster_name
      AppRole = "containers"
    }
  )

  depends_on = [
    aws_security_group_rule.cluster_egress_internet,
    aws_security_group_rule.cluster_https_worker_ingress,
    aws_iam_role_policy_attachment.eks-service-policy-attachment,
    aws_iam_role_policy_attachment.eks-vpc-resource-controller-attachment,
    aws_iam_role_policy_attachment.eks-cluster-cloud-watch-metric-policy-attachment,
    aws_iam_role_policy_attachment.eks-cluster-lb-policy-attachment,
    aws_cloudwatch_log_group.main,
  ]

  timeouts {
    create = var.timeout_for_resource_creation
    delete = var.timeout_for_resource_delete
    update = var.timeout_for_resource_update
  }
}
