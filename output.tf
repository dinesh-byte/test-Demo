# output to get ALB DNS link

output "lb_dns_name" {
  description = "DNS name of ALB"
  value       = aws_lb.ALB.dns_name

}