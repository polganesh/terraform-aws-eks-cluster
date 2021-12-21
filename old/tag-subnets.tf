resource "null_resource" "tag-public-subnet" {
  count = length(data.aws_subnet_ids.public_subnets.ids)

  provisioner "local-exec" {
    command = "aws ec2 create-tags --resources ${tolist(data.aws_subnet_ids.public_subnets.ids)[count.index]} --tags Key=kubernetes.io/role/elb,Value=1"
  }

  provisioner "local-exec" {
    command = "aws ec2 create-tags --resources ${tolist(data.aws_subnet_ids.public_subnets.ids)[count.index]} --tags Key=kubernetes.io/cluster/eks-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id},Value=shared"
  }

  depends_on = [aws_eks_cluster.main]
}

# it is important that all private app subnets must be tagged with following key.it will help k8s to add EC2 instances in these subnets to add in cluster.
resource "null_resource" "tag-privateApp-subnet" {
  count = length(data.aws_subnet_ids.private_app_subnets.ids)
  provisioner "local-exec" {
    command = "aws ec2 create-tags --resources ${tolist(data.aws_subnet_ids.private_app_subnets.ids)[count.index]} --tags Key=kubernetes.io/cluster/eks-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id},Value=shared"
  }
  depends_on = [aws_eks_cluster.main]
}