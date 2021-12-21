resource "aws_cloudwatch_log_group" "main" {
  name              = local.log_group_name
  retention_in_days = var.log_retention_in_days
 # kms_key_id        = var.encrypt_cloudwatch_logs_with_kms_key ? aws_kms_key.eks-cloudwatch-logs[0].arn : null
  # var.manage_cluster_iam_resources ? 1 : 0
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



#resource "aws_kms_key" "eks-cloudwatch-logs" {
#  count = var.encrypt_cloudwatch_logs_with_kms_key ? 1 :0
#  description             = "kms encryption key for eks"
#  deletion_window_in_days = 7
#  enable_key_rotation     = true
#  tags = {
#    Name        = "kms-${var.region_id}-${var.environment}-${var.cost_centre}-${var.app_service}Ekscwlg-${var.seq_id}"
#    RegionId    = var.region_id
#    Environment = var.environment
#    CostCentre  = var.cost_centre
#    AppService  = var.app_service
#    AppRole     = "security-identity-compliance"
#  }
#  policy = <<POLICY
#{
#    "Version": "2012-10-17",
#    "Id": "key-default-1",
#    "Statement": [
#        {
#            "Sid": "Enable IAM User Permissions",
#            "Effect": "Allow",
#            "Principal": {
#                "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
#            },
#            "Action": "kms:*",
#            "Resource": "*"
#        },
#        {
#            "Effect": "Allow",
#            "Principal": {
#                "Service": "logs.region.amazonaws.com"
#            },
#            "Action": [
#                "kms:Encrypt*",
#                "kms:Decrypt*",
#                "kms:ReEncrypt*",
#                "kms:GenerateDataKey*",
#                "kms:Describe*"
#            ],
#            "Resource": "*",
#            "Condition": {
#                "ArnLike": {
#                    "kms:EncryptionContext:aws:logs:arn": "arn:aws:logs:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:log-group:${local.log_group_name}"
#                }
#    ]
#}
#POLICY
#}