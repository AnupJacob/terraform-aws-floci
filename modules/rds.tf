resource "aws_db_subnet_group" "postgres_subnet_group" {
  for_each   = toset(var.regions)
  name       = "${var.environments[0]}-postgres-subnet-group-${each.key}"

  subnet_ids = [
    aws_subnet.my_floci_private_subnet[each.key].id,
    aws_subnet.my_floci_public_subnet[each.key].id
  ]

  tags = {
    Infrastructure = var.infrastructure
    Environment    = var.environments[0]
  }
}

resource "aws_db_instance" "aws_floci_postgres" {
  for_each               = toset(var.regions)
  identifier             = "${var.environments[0]}-postgres-db-${each.key}"

  engine                 = "postgres"
  engine_version         = "15.4"
  instance_class         = "db.t4g.micro" # Cost-effective burstable instance class for learning

  db_name                = "${var.environments[0]}-postgres-db"
  username               = var.master_user
  password               = var.master_password
  db_subnet_group_name   = aws_db_subnet_group.postgres_subnet_group[each.key].name
  skip_final_snapshot    = true

  multi_az               = true
  backup_retention_period = 7

  allocated_storage      = 20
  max_allocated_storage  = 100

  tags = {
    Infrastructure = var.infrastructure
    Environment    = var.environments[0]
  }
}