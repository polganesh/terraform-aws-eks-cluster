resource "aws_security_group_rule" "cluster_egress_internet" {
  description       = "Allow cluster egress access to the Internet."
  protocol          = "-1"
  security_group_id = aws_security_group.tf-eks-master.id
  cidr_blocks       = var.cluster_egress_cidrs
  from_port         = 0
  to_port           = 0
  type              = "egress"
}

resource "aws_security_group_rule" "cluster_https_worker_ingress" {
  description              = "Allow pods to communicate with the EKS cluster API."
  protocol                 = "tcp"
  security_group_id        = aws_security_group.tf-eks-master.id
  source_security_group_id = aws_security_group.tf-eks-worker-node.id
  from_port                = 443
  to_port                  = 443
  type                     = "ingress"
}

#resource "aws_security_group_rule" "cluster_private_access_cidrs_source" {
#  for_each = var.create_eks && var.cluster_create_endpoint_private_access_sg_rule && var.cluster_endpoint_private_access && var.cluster_endpoint_private_access_cidrs != null ? toset(var.cluster_endpoint_private_access_cidrs) : []
#
#  description = "Allow private K8S API ingress from custom CIDR source."
#  type        = "ingress"
#  from_port   = 443
#  to_port     = 443
#  protocol    = "tcp"
#  cidr_blocks = [each.value]
#
#  security_group_id = aws_eks_cluster.this[0].vpc_config[0].cluster_security_group_id
#}
#
#resource "aws_security_group_rule" "cluster_private_access_sg_source" {
#  count = var.create_eks && var.cluster_create_endpoint_private_access_sg_rule && var.cluster_endpoint_private_access && var.cluster_endpoint_private_access_sg != null ? length(var.cluster_endpoint_private_access_sg) : 0
#
#  description              = "Allow private K8S API ingress from custom Security Groups source."
#  type                     = "ingress"
#  from_port                = 443
#  to_port                  = 443
#  protocol                 = "tcp"
#  source_security_group_id = var.cluster_endpoint_private_access_sg[count.index]
#
#  security_group_id = aws_eks_cluster.this[0].vpc_config[0].cluster_security_group_id
#}