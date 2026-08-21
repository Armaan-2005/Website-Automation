output "vpc_id" {
  value = aws_vpc.my_vpc.id
}
output "pub_sub_id" {
  value = aws_subnet.pub_subnet.id
}
output "key_name" {
  value = aws_key_pair.key_pair.key_name
}
output "sg" {
  value = aws_security_group.my_sg.id
}