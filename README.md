# oyd-exercise-6-2 — ALB with Listener and Target Group

This repository provisions an Application Load Balancer (ALB) in front of the existing MediaStream API EC2 instance using Terraform.

## Architecture

- **VPC & EC2** — provisioned by the `setup/` workspace (run once before the root workspace).
- **ALB Security Group** — allows inbound HTTP on port 80 from the internet.
- **Target Group** — registers the existing EC2 instance with a health check on `/`.
- **ALB** — internet-facing application load balancer spanning the two public subnets.
- **Listener** — forwards HTTP traffic on port 80 to the target group.

## Prerequisites

- AWS CLI configured with credentials.
- Terraform >= 1.8.

## Usage

### 1. Provision the base infrastructure

```bash
cd setup/
terraform init
terraform apply -auto-approve
cd ..
```

### 2. Provision the ALB layer

```bash
terraform init
terraform apply -var-file=terraform.tfvars
```

## Evidence

### terraform state list

```
data.aws_instance.api
data.aws_subnets.public
data.aws_vpc.main
aws_lb.main
aws_lb_listener.http
aws_lb_target_group.api
aws_lb_target_group_attachment.api
aws_security_group.alb
```

### terraform output

```
alb_arn          = "arn:aws:elasticloadbalancing:us-east-1:676206925447:loadbalancer/app/mediastream-alb/9a373bb81c826df1"
alb_dns_name     = "mediastream-alb-2005370350.us-east-1.elb.amazonaws.com"
target_group_arn = "arn:aws:elasticloadbalancing:us-east-1:676206925447:targetgroup/mediastream-api-tg/56dc5b6add78dcca"
```
