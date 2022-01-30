resource "aws_security_group" "tf-eks-master" {
  name        = "sgr-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Master-${var.seq_id}"
  description = "EKS Cluster security group."
  vpc_id      = data.aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    local.generic_tags,
    {
      Name    = "sgr-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Master-${var.seq_id}"
      AppRole = "network"
    }
  )
}



resource "aws_security_group" "tf-eks-worker-node" {
  name        = "sgr-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Wnode-${var.seq_id}"
  description = "EKS worker node  security group."
  vpc_id      = data.aws_vpc.vpc.id
  tags = merge(
    var.common_tags,
    local.generic_tags,
    {
      Name    = "sgr-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Master-${var.seq_id}"
      AppRole = "network"
    }
  )
}

