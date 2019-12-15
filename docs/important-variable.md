# Important Variables

## Variables for VPC and Subnet Discovery for worker node discovery

|variable name |is required	|Default Value|Type	  | Notes       	 		                    |
|:-------------|:-----------|:------------|:------|:--------------------------------------|
|region				 |N		        |eu-west-1		|String	|Valid AWS Region                       |
|region_id		 |N		        |euw1     		|String	|Region Identifier.for more information refer region_id section present for VPC[at](https://github.com/polganesh/terraform-aws-vpc) |
|cost_centre	 |N		        |na     		  |String	|refer cost_centre section present for VPC[at](https://github.com/polganesh/terraform-aws-vpc) |
|vpc_seq_id	   |N		        |001     		  |String	|refer information for vpc_seq_id for VPC[at](https://github.com/polganesh/terraform-aws-vpc) |
|environment	 |N		        |dev     		  |String	|refer information for environment for VPC[at](https://github.com/polganesh/terraform-aws-vpc) |

> This will create EKS cluster in VPC which has  tag with key _Name_ has value **starts** with vpc-{region_id} and **ends** with {cost_centre}-{vpc_seq_id}

> Create Worker Nodes private subnet in VPC based on above criteria and has tag with key _Name_ has value **contains** -privApp-

## Variables for worker nodes
|variable name |is required	|Default Value|Type	  | Notes       	 		                    |
|:-------------|:-----------|:------------|:------|:--------------------------------------|
|image_id			 |Y		        |         		|String	|EKS optimized Image [Refer](https://docs.aws.amazon.com/eks/latest/userguide/eks-optimized-ami.html)                |
|key_name			 |Y		        |         		|String	|AWS key pair                |

## Other Variables
|variable name |is required	|Default Value|Type	  | Notes       	 		                    |
|:-------------|:-----------|:------------|:------|:--------------------------------------|
|app_service	 |Y		        |         		|String	|Indicator for EKS.                     |
|eks_version	 |N		        |1.12      		|String	|K8s Version.                           |

> Please note although K8s provide minor version in the form of X.yy.zz. in AWS EKS support only X.yy. any attempt to provide minor version will result in error.

## Security
|variable name |is required	|Default Value|Type	  | Notes       	 		                    |
|:-------------|:-----------|:------------|:------|:--------------------------------------|
|inbound_cidr_rules_for_workstation_https	 |Y		        |      		|list	|list of CIDR of local development machine to connect cluster                 |

## Logging and Monitoring
|variable name |is required	|Default Value|Type	  | Notes       	 		                    |
|:-------------|:-----------|:------------|:------|:--------------------------------------|
|control_plane_logging_to_be_enabled	 |Y		        |      		|list	|possible values api, authenticator, controllerManager, scheduler                 |
|worker_node_enable_detailed_monitoring	 |N	        |false      		|string	|if true then detailed monitoring enabled for worker node|


