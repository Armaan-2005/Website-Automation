output "website_url" {
  value = "http://${aws_instance.ec2.public_ip}"
}
output "instance_id" {
  value = aws_instance.ec2.id
}