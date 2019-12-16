# terraform-aws-eks-cluster
This is Terraform module to provision managed K8s (Elastic Kubernetes Service) service  for AWS

# Capabilities of this Module
+ This module provide facility to create EKS based on name pattern of VPC and subnets(for more information refer following)
+ **Maintainability and Readability** - Make AWS resources more readable when navigating in AWS console. This became  more useful when your AWS account has lot of resources.
+ **Improved Security** - Provide improved security by _**enforcing**_ worker nodes in private subnets
+ **Tracking** - Attach predefined tags to AWS resources. These tags play major role in tracking resources for
  * Monitoring. tools like Datadog depends heavily on tags
  * Cost
+ **Cost Control** - Facility to run Worker nodes of type _**Reserved**_ and _**Spot**_  

## Dependencies and Prerequisites
- Terraform version 0.12 and higher
- AWS account
- AWS CLI
- AWS VPC based on module available [at](https://github.com/polganesh/terraform-aws-vpc)

> Please note- This module heavily depends on VPC module mentioned above and VPC must be present before working with this module.

## [Important Variables](https://github.com/polganesh/terraform-aws-eks-cluster/blob/master/docs/important-variable.md "Important Variables")

## [Example](https://github.com/polganesh/terraform-aws-eks-cluster/blob/update-readme/docs/example.md "Example")






