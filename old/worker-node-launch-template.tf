resource "aws_launch_template" "main" {
  name                   = "launchtmplt-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Eks-${var.seq_id}"
  image_id               = var.image_id
  key_name               = var.key_name
  ebs_optimized          = var.worker_node_ebs_optimized
  vpc_security_group_ids = [aws_security_group.tf-eks-node.id]
  user_data              = base64encode(local.worker-node-userdata)
  lifecycle {
    create_before_destroy = true
  }

  iam_instance_profile {
    arn = aws_iam_instance_profile.node.arn
  }

  monitoring {
    enabled = var.worker_node_enable_detailed_monitoring
  }

  capacity_reservation_specification {
    capacity_reservation_preference = var.worker_node_capacity_reservation_preference
  }

  credit_specification {
    cpu_credits = var.worker_node_cpu_credits
  }

  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.common_tags,
      var.tag_for_worker_nodes,
      {
        Name        = "ec2-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Eks-${var.seq_id}"
        RegionId    = var.region_id
        Environment = var.environment
        CostCentre  = var.cost_centre
        VPCSeqId    = var.vpc_seq_id
        VersionId   = var.version_id
        BuildDate   = var.build_date
        AppRole     = "compute"
      },
      {
        "kubernetes.io/cluster/eks-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}-${var.seq_id}" = "owned"
      }
    )
  }

}   