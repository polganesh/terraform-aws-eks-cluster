##################################
# Data
##################################
##################################

# get reference of aws VPC which contains name as value of <cost_centre>-<vpc_seq_id>
data "aws_vpc" "vpc" {
  filter {
    name   = "tag:Name"
    values = ["vpc-${var.region_id}*-${var.cost_centre}-${var.vpc_seq_id}"]
  }
}

# get reference of subnet which contains name as privApp
data "aws_subnet_ids" "private_app_subnets" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags = {
    Name = "*-privApp-*"
  }
}

# get reference of subnet which contains name as -pub- in aws_vpc.vpc
data "aws_subnet_ids" "public_subnets" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags = {
    Name = "*-pub-*"
  }
}

# and can be swapped out as necessary.
data "aws_region" "current" {}

# get reference of aws availability zones
data "aws_availability_zones" "main" {}

