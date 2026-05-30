data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
  filter {
    name   = "isDefault"
    values = ["false"]
  }
  filter {
    name   = "cidr"
    values = ["10.0.0.0/16"]
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  tags = {
    Tier = "public"
  }
}

data "aws_instance" "api" {
  filter {
    name   = "tag:Name"
    values = [var.instance_name]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}
