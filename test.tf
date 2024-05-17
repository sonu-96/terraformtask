provider "aws" {
  access_key = var.access_key
  secret_key = var.secret_key
  region = "us-east-2"
}

resource "aws_ecs_cluster" "terracluster" {
  name = "terracluster"
}


resource "aws_ecs_task_definition" "mytask_terra_definition" {
  family = "mytask"
  container_definitions = jsonencode([{
    name = "terra-container"
    image = "docker.io/mdhack/myapache"
    cpu = 256
    memory = 512
    portMapping = [{
        containerPort = 80
        hostPort = 80
    }] 
  }])
}

resource "aws_ecs_service" "terra_service" {
  name = "terra_service"
  cluster = aws_ecs_cluster.terracluster.id
  task_definition = aws_ecs_task_definition.mytask_terra_definition.arn
  desired_count = 1
}

resource "aws_lb" "my-lb" {
  name = "my-lb"
  internal = false
  load_balancer_type = "application"
  security_groups = [aws_security_group.lb-sg.id]
  subnets = [aws_subnet.lb_subnet1.id , aws_subnet.lb_subnet2.id]
}

resource "aws_lb_listener" "frontend" {
  load_balancer_arn = aws_lb.my-lb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.my_lbgroup.arn
  }
}

resource "aws_lb_target_group" "my_lbgroup" {
  name = "my-lbgroup"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.lb_vpc.id
}
