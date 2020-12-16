variable "polder_main_db_name" {
  default = ""
}

variable "polder_main_db_username" {
  default = ""
}

variable "polder_main_db_password" {
  default = ""
}

variable "polder_docdb_username" {
  default = ""
}

variable "polder_docdb_password" {
  default = ""
}

resource "aws_db_instance" "polder_main_db" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "postgres"
  engine_version       = "12.4"
  instance_class       = "db.t3.micro"
  name                 = var.polder_main_db_name
  username             = var.polder_main_db_username
  password             = var.polder_main_db_password
  publicly_accessible  = true
}

resource "aws_docdb_cluster_instance" "polder_docdb_instances" {
  count              = 1
  identifier         = "polder-docdb-cluster-${count.index}"
  cluster_identifier = aws_docdb_cluster.polder_broker_docdb.id
  instance_class     = "db.t3.medium"
}

resource "aws_docdb_cluster" "polder_broker_docdb" {
  cluster_identifier      = "polder-broker-docdb"
  engine                  = "docdb"
  master_username         = var.polder_docdb_username
  master_password         = var.polder_docdb_password
  backup_retention_period = 5
  preferred_backup_window = "01:00-03:00"
  skip_final_snapshot     = true
}

output "polder-main-db" {
  value = "postgres://${aws_db_instance.polder_main_db.username}:${aws_db_instance.polder_main_db.password}@${aws_db_instance.polder_main_db.endpoint}/${aws_db_instance.polder_main_db.name}"
}

output "polder-docdb" {
  value = "mongo://${aws_docdb_cluster.polder_broker_docdb.endpoint}"
}
