#instance creation
# public instance 1
resource "aws_instance" "public1" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.publicsubnet1.id
  security_groups             = [aws_security_group.pubSG.id]
  #user_data                   = file("user.tpl.sh")
  associate_public_ip_address = true
 
  tags = {
    "Name" = "public instance 1"
  }
}

# public instance 2

resource "aws_instance" "public2" {
  ami                         = var.ami
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.publicsubnet2.id
  security_groups             = [aws_security_group.pubSG.id]
  #user_data                   = file("user1.tpl.sh")
  associate_public_ip_address = true
  
  tags = {
    "Name" = "public instance 2"
  }
}
