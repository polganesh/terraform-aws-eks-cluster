resource "aws_autoscaling_group" "main" {
  name                = "asg-${var.region_id}-${var.environment}-${var.cost_centre}-vpc${var.vpc_seq_id}-${var.app_service}Eks-${var.seq_id}"
  desired_capacity    = var.desired_capacity
  min_size            = var.min_size
  max_size            = var.max_size
  vpc_zone_identifier = flatten([data.aws_subnet_ids.private_app_subnets.ids])
  health_check_type   = var.worker_node_health_check_type
  mixed_instances_policy {
    launch_template {
      launch_template_specification {
        launch_template_id = aws_launch_template.main.id
        version            = aws_launch_template.main.latest_version

      }
      #enable multiple instance types
      dynamic "override" {
        for_each = var.worker_node_instance_types
        content {
          instance_type = override.value["instance_type"]
        }
      }
    }

    instances_distribution {
      on_demand_base_capacity                  = var.worker_node_on_demand_base_capacity
      on_demand_percentage_above_base_capacity = var.worker_node_on_demand_percentage_above_base_capacity
      spot_allocation_strategy                 = var.worker_node_spot_allocation_strategy
      spot_instance_pools                      = var.worker_node_spot_instance_pools
      spot_max_price                           = var.worker_node_spot_max_price
    }
  }
}
