#-----------------------------------------------------------------------------------------
# Setup IAM role & instance profile for worker nodes
# These permissions allow our following resources to start up and control EC2 instances,
# which is the service that will implement our actual application nodes.
#-----------------------------------------------------------------------------------------

resource "aws_iam_role" "wnode" {
  name = "rol-glob-${var.environment}-${var.cost_centre}-${var.app_service}Wnd-${random_string.eks-iam-role-policy-suffix.result}-${var.seq_id}"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role_policy_attachment" "tf-eks-node-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.wnode.name
}

resource "aws_iam_role_policy_attachment" "tf-eks-node-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.wnode.name
}

resource "aws_iam_role_policy_attachment" "tf-eks-node-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.wnode.name
}

resource "aws_iam_instance_profile" "node" {
  name = "iamprof-glob-${var.environment}-${var.cost_centre}-${var.app_service}Wnd-${random_string.eks-iam-role-policy-suffix.result}-${var.seq_id}"
  role = aws_iam_role.wnode.name
}