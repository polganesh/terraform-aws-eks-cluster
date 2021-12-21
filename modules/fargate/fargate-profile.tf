resource "aws_eks_fargate_profile" "fargate-profile" {
  for_each = local.fargate_profiles
    cluster_name = var.cluster_name
    fargate_profile_name = lookup(each.value, "name", format("%s-fargate-%s", var.cluster_name, replace(each.key, "_", "-")))
    pod_execution_role_arn = aws_iam_role.eks_fargate_pod.arn
    subnet_ids             = lookup(each.value, "subnets", var.subnets)

    dynamic "selector" {
    for_each = each.value.selectors

    content {
      namespace = selector.value["namespace"]
      labels    = lookup(selector.value, "labels", {})
    }
  }
  timeouts {
    create = try(each.value["timeouts"].create, null)
    delete = try(each.value["timeouts"].delete, null)
  }


}
