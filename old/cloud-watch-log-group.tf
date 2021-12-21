# LogGroup
resource "aws_cloudwatch_log_group" "main" {
  name              = "lgrp-eks-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id}"
  retention_in_days = var.log_retention_in_days

  tags = {
    Name        = "lgrp-eks-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id}"
    RegionId    = var.region_id
    Environment = var.environment
    CostCentre  = var.cost_centre
    VPCSeqId    = var.vpc_seq_id
    VersionId   = var.version_id
    BuildDate   = var.build_date
    AppRole     = "management"
  }
}
