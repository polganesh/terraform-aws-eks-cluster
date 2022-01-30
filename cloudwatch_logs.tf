resource "aws_cloudwatch_log_group" "main" {
  name              = local.log_group_name
  retention_in_days = var.log_retention_in_days
  tags = merge(
    var.common_tags,
    var.tag_for_cloud_watch_log_group,
    local.generic_tags,
    {
      Name    = local.log_group_name
      AppRole = "management"
    }
  )
}
