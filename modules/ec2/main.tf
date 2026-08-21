resource "aws_instance" "ec2" {
  ami = var.ubuntu
  instance_type = var.inst_type
  key_name = var.key
  subnet_id = var.subnet
  associate_public_ip_address = true
  vpc_security_group_ids = var.vpc-sg
  user_data = <<-EOF
            #!/bin/bash
            sudo su -
            apt update -y
            apt install docker.io -y

            systemctl enable docker
            systemctl start docker

            docker pull mohammedarmaan2005/webpage:latest

            docker run --name my-website -d -p 80:80 mohammedarmaan2005/webpage:latest
            EOF
  tags = {
    Name = "webpage-test"
  }
}