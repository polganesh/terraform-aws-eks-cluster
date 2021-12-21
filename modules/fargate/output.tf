output "fargate_profile_ids" {
  description = "EKS Cluster name and EKS Fargate Profile names separated by a colon (:)."
  value       = [for f in aws_eks_fargate_profile.fargate-profile : f.id]
}

output "fargate_profile_arns" {
  description = "Amazon Resource Name (ARN) of the EKS Fargate Profiles."
  value       = [for f in aws_eks_fargate_profile.fargate-profile : f.arn]
}

output "iam_role_name" {
  description = "IAM role name for EKS Fargate pods"
  value       = aws_iam_role.eks_fargate_pod.name
}

output "iam_role_arn" {
  description = "IAM role ARN for EKS Fargate pods"
  value       = aws_iam_role.eks_fargate_pod.arn
}

output "aws_auth_roles" {
  description = "Roles for use in aws-auth ConfigMap"
  value = [
    for i in range(1) : {
      worker_role_arn = aws_iam_role.eks_fargate_pod.arn
      platform        = "fargate"
    }
  ]
}
