terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>4.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}

resource "aws_instance" "tf-docker-ec2" {
  ami = "ami-022e1a32d3f742bd8"
  instance_type = "t2.micro"
  key_name = "first-key"
  vpc_security_group_ids = [aws_security_group.tf-docker-sec-gr.id]
  tags = {
    Name = "Web Server"
  }
  user_data = <<-EOF
          #! /bin/bash
          yum update -y
          yum install docker -y
          systemctl start docker
          systemctl enable docker
          usermod -a -G docker ec2-user
          newgrp docker
          curl -SL https://github.com/docker/compose/releases/download/v2.16.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose
          chmod +x /usr/local/bin/docker-compose
          mkdir -p /home/ec2-user/QuickDBTest.php
          # TOKEN="xxxxxxxxxxxxxxxxxxxxx"
          # FOLDER="https://$TOKEN@raw.githubusercontent.com/ofidan/oliver-repo/main/"
          FOLDER="https://raw.githubusercontent.com/Salihugurlu/Salih-devops-task/main/"
          curl -s --create-dirs -o "/home/ec2-user/QuickDBTest.php/salihapp" -L "$FOLDER"QuickDBTest.php
          curl -s --create-dirs -o "/home/ec2-user/QuickDBTest.php/main.tf" -L "$FOLDER"main.tf
          curl -s --create-dirs -o "/home/ec2-user/QuickDBTest.php/Dockerfile" -L "$FOLDER"Dockerfile
          curl -s --create-dirs -o "/home/ec2-user/QuickDBTest.php/docker-compose.yml" -L "$FOLDER"docker-compose.yml
          cd /home/ec2-user/QuickDBTest.php
          docker build -t salihijk/quickdbtest .
          docker-compose up -d
          EOF

}

resource "aws_security_group" "tf-docker-sec-gr" {
  name = "docker-sec-gr-QuickDbTest."
  tags = {
    Name = "docker-sec-QuickDbTest."
  }
  ingress {
    from_port   = 80
    protocol    = "tcp"
    to_port     = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    protocol    = "tcp"
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    protocol    = -1
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "website" {
  value = "http://${aws_instance.tf-docker-ec2.public_dns}"

}