# oyd-exercise-6-2 — ALB con Listener y Target Group

Este repositorio aprovisiona un Application Load Balancer (ALB) frente a la instancia EC2 existente de la API de MediaStream usando Terraform.

## Arquitectura

- **VPC y EC2** — aprovisionados por el workspace `setup/` (ejecutar una sola vez antes del workspace raíz).
- **Security Group del ALB** — permite tráfico HTTP entrante en el puerto 80 desde internet.
- **Target Group** — registra la instancia EC2 existente con un health check en `/`.
- **ALB** — balanceador de carga de aplicación orientado a internet, distribuido en las dos subnets públicas.
- **Listener** — reenvía el tráfico HTTP en el puerto 80 al target group.

## Prerrequisitos

- AWS CLI configurado con credenciales válidas.
- Terraform >= 1.8.

## Uso

### 1. Aprovisionar la infraestructura base

```bash
cd setup/
terraform init
terraform apply -auto-approve
cd ..
```

### 2. Aprovisionar la capa del ALB

```bash
terraform init
terraform apply -var-file=terraform.tfvars
```

## Evidencia

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
