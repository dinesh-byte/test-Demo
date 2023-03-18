# creating a RDS database

resource "aws_db_instance" "RDS" {
  allocated_storage      = 10
  db_subnet_group_name   = aws_db_subnet_group.default.id
  engine                 = "mysql"
  engine_version         = "5.7"
  instance_class         = "db.t3.micro"
  username               = var.username
  password               = var.password
  vpc_security_group_ids = [aws_security_group.pubSG.id]
  availability_zone      = var.availability_zone3
  multi_az               = false
  tags = {
    "Name" = "terraform_db"
  }

}

# creating a db subnet

resource "aws_db_subnet_group" "default" {
  subnet_ids = [aws_subnet.privatesubnet1.id, aws_subnet.privatesubnet2.id]

}