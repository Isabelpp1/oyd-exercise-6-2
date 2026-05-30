output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer."
  value       = aws_lb.main.dns_name
}

output "alb_arn" {
  description = "The ARN of the Application Load Balancer."
  value       = aws_lb.main.arn
}

output "target_group_arn" {
  description = "The ARN of the target group attached to the ALB."
  value       = aws_lb_target_group.api.arn
}
