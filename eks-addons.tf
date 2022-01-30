resource "aws_eks_addon" "this" {
  for_each     = { for k, v in var.cluster_addons : k => v }
  cluster_name = aws_eks_cluster.main.name
  addon_name   = try(each.value.name, each.key)

  addon_version            = lookup(each.value, "addon_version", null)
  resolve_conflicts        = lookup(each.value, "resolve_conflicts", null)
  service_account_role_arn = lookup(each.value, "service_account_role_arn", null)

  lifecycle {
    ignore_changes = [
      modified_at
    ]
  }

  tags = merge(
    var.common_tags,
    local.generic_tags
  )
}
