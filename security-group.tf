resource "aws_security_group" "tf-eks-master" {
  name        = "sgr-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Master-${var.seq_id}"
  description = "Cluster communication with worker nodes."
  vpc_id      = data.aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sgr-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Master-${var.seq_id}"
    RegionId    = var.region_id
    Environment = var.environment
    CostCentre  = var.cost_centre
    VPCSeqId    = var.vpc_seq_id
    VersionId   = var.version_id
    BuildDate   = var.build_date
    AppRole     = "network"
  }
}

resource "aws_security_group" "tf-eks-node" {
  name        = "sgr-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Wnode-${var.seq_id}"
  description = "Allow workstation to communicate with the cluster API Server"
  vpc_id      = data.aws_vpc.vpc.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "sgr-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Wnode-${var.seq_id}"
    RegionId    = var.region_id
    Environment = var.environment
    CostCentre  = var.cost_centre
    VPCSeqId    = var.vpc_seq_id
    VersionId   = var.version_id
    BuildDate   = var.build_date
    AppRole     = "network"
  }
}