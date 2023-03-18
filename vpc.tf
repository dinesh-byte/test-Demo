#vpc creation

resource "aws_vpc" "terra_project" {
  cidr_block       = var.cidr_blockvpc
  instance_tenancy = "default"

  tags = {
    Name = "terra_project"
  }
}

#internet gateway

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.terra_project.id

  tags = {
    Name = "igw-project"
  }
}

#public subnet 1
resource "aws_subnet" "publicsubnet1" {

  availability_zone = var.availability_zone1
  cidr_block        = var.cidr_blockpublic1
  vpc_id            = aws_vpc.terra_project.id

  tags = {
    Name = "public subnet 1"
  }
}

#public subnet 2

resource "aws_subnet" "publicsubnet2" {

  availability_zone = var.availability_zone2
  cidr_block        = var.cidr_blockpublic2
  vpc_id            = aws_vpc.terra_project.id

  tags = {
    Name = "public subnet 2"
  }
}

#private subnet 1

resource "aws_subnet" "privatesubnet1" {

  availability_zone       = var.availability_zone3
  cidr_block              = var.cidr_blockprivate
  vpc_id                  = aws_vpc.terra_project.id
  map_public_ip_on_launch = false

  tags = {
    Name = "private subnet1"
  }
}

#private subnet 2

resource "aws_subnet" "privatesubnet2" {

  availability_zone       = var.availability_zone1
  cidr_block              = var.cidr_blockprivate2
  vpc_id                  = aws_vpc.terra_project.id
  map_public_ip_on_launch = false

  tags = {
    Name = "private subnet2"
  }
}




#route table public 1

resource "aws_route_table" "publicRT1" {
  vpc_id = aws_vpc.terra_project.id

  tags = {
    "Name" = "publicRT1"
  }
}

#route table public 2

resource "aws_route_table" "publicRT2" {
  vpc_id = aws_vpc.terra_project.id

  tags = {
    "Name" = "publicRT2"
  }
}

#route table private 1 

resource "aws_route_table" "privateRT1" {
  vpc_id = aws_vpc.terra_project.id

  tags = {
    "Name" = "privateRT1"
  }
}

#route table private 2

resource "aws_route_table" "privateRT2" {
  vpc_id = aws_vpc.terra_project.id

  tags = {
    "Name" = "privateRT2"
  }
}


#rt association pub 1

resource "aws_route_table_association" "pubRT1" {

  subnet_id      = aws_subnet.publicsubnet1.id
  route_table_id = aws_route_table.publicRT1.id

}

#rt association pub 2

resource "aws_route_table_association" "pubRT2" {

  subnet_id      = aws_subnet.publicsubnet2.id
  route_table_id = aws_route_table.publicRT2.id

}

#Rt association private 1

resource "aws_route_table_association" "priRT" {

  subnet_id      = aws_subnet.privatesubnet1.id
  route_table_id = aws_route_table.privateRT1.id

}

#Rt association private 2

resource "aws_route_table_association" "priRT2" {

  subnet_id      = aws_subnet.privatesubnet2.id
  route_table_id = aws_route_table.privateRT2.id

}

#ellastic IP 1

resource "aws_eip" "elastic" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

}

#ellastic IP 2

resource "aws_eip" "elastic2" {
  vpc        = true
  depends_on = [aws_internet_gateway.igw]

}


# nat gateway pri 1

resource "aws_nat_gateway" "project_nat" {
  allocation_id = aws_eip.elastic.id
  subnet_id     = aws_subnet.publicsubnet1.id
  depends_on    = [aws_internet_gateway.igw]
}

# nat gateway pri 1

resource "aws_nat_gateway" "project_nat2" {
  allocation_id = aws_eip.elastic2.id
  subnet_id     = aws_subnet.publicsubnet2.id
  depends_on    = [aws_internet_gateway.igw]
}

# routing internet to rt 1

resource "aws_route" "internet1" {
  route_table_id         = aws_route_table.publicRT1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

# routing internet to rt 2

resource "aws_route" "internet2" {
  route_table_id         = aws_route_table.publicRT2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}


# routing nat 1

resource "aws_route" "pri" {
  route_table_id         = aws_route_table.privateRT1.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.project_nat.id

}

# routing nat 1

resource "aws_route" "pri2" {
  route_table_id         = aws_route_table.privateRT2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.project_nat2.id

}

#security public

resource "aws_security_group" "pubSG" {
  vpc_id = aws_vpc.terra_project.id
  tags = {
    "Name" = "pubSG"
  }
  ingress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol    = "tcp"
    from_port   = 0
    to_port     = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }

}

#security private

resource "aws_security_group" "priSG" {
  vpc_id = aws_vpc.terra_project.id
  tags = {
    "Name" = "priSG"
  }
  ingress {
    protocol        = "tcp"
    from_port       = 0
    to_port         = 65535
    security_groups = [aws_security_group.pubSG.id]
  }

  egress {
    protocol        = "tcp"
    from_port       = 0
    to_port         = 65535
    security_groups = [aws_security_group.pubSG.id]
  }

}






