
# creating application load balancer

resource "aws_lb" "ALB" {
    
    security_groups = [aws_security_group.pubSG.id]
    load_balancer_type = "application"
    tags = {
      "Name" = "ALB_TERRAFORM"
    }
    subnet_mapping {
      subnet_id = aws_subnet.publicsubnet1.id
    }
    subnet_mapping {
      subnet_id = aws_subnet.publicsubnet2.id
    }
}


#target group

resource "aws_lb_target_group" "ALB_target" {
    
    vpc_id = aws_vpc.terra_project.id
    port = 80
    protocol = "HTTP"
    
}

#listener group

resource "aws_lb_listener" "ALB_listener" {
    port = 80
    protocol = "HTTP"
    load_balancer_arn = aws_lb.ALB.id

    default_action {
      type = "forward"
      target_group_arn = aws_lb_target_group.ALB_target.id 
    }
}

#target group attachment 1

resource "aws_lb_target_group_attachment" "ALB1" {
    target_group_arn = aws_lb_target_group.ALB_target.id
    target_id = aws_instance.public1.id
}

#target group attachment 1

resource "aws_lb_target_group_attachment" "ALB2" {
    target_group_arn = aws_lb_target_group.ALB_target.id
    target_id = aws_instance.public2.id
} 