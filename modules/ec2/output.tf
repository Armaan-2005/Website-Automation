output "website_url" {
  value = "http://${aws_instance.ec2.public_ip}"
}