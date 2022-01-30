# terraform-aws-eks-cluster
This is Terraform module to provision managed K8s (Elastic Kubernetes Service) service  for AWS
# Capabilities of this Module
+ This module provide facility to create EKS based on name pattern of VPC and subnets(for more information refer following)
+ **Maintainability and Readability** - Make AWS resources more readable when navigating in AWS console. This became  more useful when your AWS account has lot of resources.
+ **Improved Security** - Provide improved security by _**enforcing**_ worker nodes in private subnets
+ **Tracking** - Attach predefined tags to AWS resources. These tags play major role in tracking resources for
  * Monitoring tools like Datadog,New Relic..  (depends heavily on tags
  * Cost
+ **Cost Control** - Facility to run Worker nodes as _**managed worker nodes_** and on fargate
+ **Operational Benefits** - 
  + Run worker nodes  as managed worker node. it takes care of various heavy lifting jobs by AWS.
  + Execute Spikes,short living tx on Fargate
+ Facility to provide Addon for EKS
+ IAM Role for Service account (IRSA) for openid
## Dependencies and Prerequisites
- Terraform version 0.12 and higher
- AWS account
- AWS CLI
- AWS VPC based on module available [at](https://github.com/polganesh/terraform-aws-vpc)

## Please note
- This module heavily depends on VPC module mentioned above and VPC must be present before working with this module.
- This module is not supporting customer managed node groups as it has some operational challenges.

## [Important Variables](https://github.com/polganesh/terraform-aws-eks-cluster/blob/master/docs/important-variable.md "Important Variables")

## [Example](https://github.com/polganesh/terraform-aws-eks-cluster/blob/master/docs/example.md "Example")

![alt text](https://github.com/polganesh/terraform-aws-eks-cluster/blob/new-features/docs/images/vpc.drawio.svg?raw=true)







