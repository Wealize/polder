variable "polder_main_db_name" {
  default = ""
}

variable "polder_main_db_username" {
  default = ""
}

variable "polder_main_db_password" {
  default = ""
}

variable "wirecloud_db_name" {
  default = ""
}

variable "wirecloud_db_username" {
  default = ""
}

variable "wirecloud_db_password" {
  default = ""
}

variable "keyrock_db_name" {
  default = ""
}

variable "keyrock_db_username" {
  default = ""
}

variable "keyrock_db_password" {
  default = ""
}

resource "aws_security_group" "ssh" {
  name        = "default-ssh"
  description = "Security group for nat instances that allows SSH and VPN traffic from internet"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "postgres" {
  name        = "default-postgres"
  description = "Security group postgres database"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "mysql" {
  name        = "default-mysql"
  description = "Security group mysql database"

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "mongo" {
  name        = "default-mongo"
  description = "Security group mongo database"

  ingress {
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "egress-tls" {
  name        = "default-egress-tls"
  description = "Default security group that allows inbound and outbound traffic from all instances in the VPC"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "ping-ICMP" {
  name        = "default-ping"
  description = "Default security group that allows to ping the instance"

  ingress {
    from_port        = -1
    to_port          = -1
    protocol         = "icmp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "aws_db_instance" "wirecloud_db" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.4"
  instance_class       = "db.t3.micro"

  vpc_security_group_ids = [
    aws_security_group.postgres.id,
  ]

  name                 = var.wirecloud_db_name
  username             = var.wirecloud_db_username
  password             = var.wirecloud_db_password
  publicly_accessible  = true
}

output "wirecloud-db" {
  value = "postgres://${aws_db_instance.wirecloud_db.username}:${aws_db_instance.wirecloud_db.password}@${aws_db_instance.wirecloud_db.endpoint}/${aws_db_instance.wirecloud_db.name}"
}

resource "aws_db_instance" "keyrock_db" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "5.7.31"
  instance_class       = "db.t3.micro"

  vpc_security_group_ids = [
    aws_security_group.mysql.id,
  ]

  name                 = var.keyrock_db_name
  username             = var.keyrock_db_username
  password             = var.keyrock_db_password
  publicly_accessible  = true
}

output "keyrock-db" {
  value = "mysql://${aws_db_instance.keyrock_db.username}:${aws_db_instance.keyrock_db.password}@${aws_db_instance.keyrock_db.endpoint}/${aws_db_instance.keyrock_db.name}"
}

resource "aws_db_instance" "polder_main_db" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.4"
  instance_class       = "db.t3.micro"

  vpc_security_group_ids = [
    aws_security_group.postgres.id,
  ]

  name                 = var.polder_main_db_name
  username             = var.polder_main_db_username
  password             = var.polder_main_db_password
  publicly_accessible  = true
}

output "polder-main-db" {
  value = "postgres://${aws_db_instance.polder_main_db.username}:${aws_db_instance.polder_main_db.password}@${aws_db_instance.polder_main_db.endpoint}/${aws_db_instance.polder_main_db.name}"
}

resource "aws_instance" "polder-orion-mongo" {
  ami           = "ami-06bceec69cfdd5146"  # MONGO 4.4 in Frankfurt eu-central-1
  instance_type = "t2.medium"
  key_name      = "polder"

  vpc_security_group_ids = [
    aws_security_group.ssh.id,
    aws_security_group.mongo.id,
    aws_security_group.egress-tls.id,
    aws_security_group.ping-ICMP.id
  ]

  tags = {
    Name = "polder-mongo"
  }
}

output "polder-orion-mongo" {
  value = "ssh ${aws_instance.polder-orion-mongo.public_ip}:22"
}
