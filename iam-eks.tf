#-------------------------------------------------
# This will perform two things
# create IAM role for EKS and attach it following policies
#  AmazonEKSClusterPolicy
#  AmazonEKSServicePolicy
#--------------------------------------------------
resource "aws_iam_role" "eks-role" {
  name                  = "rol-glob-${var.environment}-${var.cost_centre}-${var.app_service}eks-${random_string.eks-iam-role-policy-suffix.result}-${var.seq_id}"
  force_detach_policies = true
  assume_role_policy    = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": [
          "eks.amazonaws.com",
          "eks-fargate-pods.amazonaws.com"
          ]
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

# Policy help publish (PUT) metric data to cloud watch
# Publishes metric data points to Amazon CloudWatch.
# https://docs.aws.amazon.com/AmazonCloudWatch/latest/APIReference/API_PutMetricData.html
resource "aws_iam_policy" "AmazonEKSClusterCloudWatchMetricsPolicy" {
  name   = "pol-glob-${var.environment}-${var.cost_centre}-${var.app_service}eksClWatch-${random_string.eks-iam-role-policy-suffix.result}-${var.seq_id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "cloudwatch:PutMetricData"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

#policy for helping eks work with load balancer
resource "aws_iam_policy" "AmazonEKSClusterLBPolicy" {
  name   = "pol-glob-${var.environment}-${var.cost_centre}-${var.app_service}eksElb-${random_string.eks-iam-role-policy-suffix.result}-${var.seq_id}"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": [
                "elasticloadbalancing:*",
                "ec2:CreateSecurityGroup",
                "ec2:Describe*"
            ],
            "Resource": "*",
            "Effect": "Allow"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks-cluster-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.eks-role.name
}

resource "aws_iam_role_policy_attachment" "eks-service-policy-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  role       = aws_iam_role.eks-role.name
}

resource "aws_iam_role_policy_attachment" "eks-vpc-resource-controller-attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.eks-role.name
}

resource "aws_iam_role_policy_attachment" "eks-cluster-cloud-watch-metric-policy-attachment" {
  policy_arn = aws_iam_policy.AmazonEKSClusterCloudWatchMetricsPolicy.arn
  role       = aws_iam_role.eks-role.name
}

resource "aws_iam_role_policy_attachment" "eks-cluster-lb-policy-attachment" {
  policy_arn = aws_iam_policy.AmazonEKSClusterLBPolicy.arn
  role       = aws_iam_role.eks-role.name
}
