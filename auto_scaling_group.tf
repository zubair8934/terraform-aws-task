# Create Auto Scaling Group
resource "aws_autoscaling_group" "my_wp_auto_scaling" {
  name              = "my_wp_auto_scaling"
  desired_capacity  = 2
  max_size          = 5
  min_size          = 1
  force_delete      = true
  depends_on        = [aws_lb.My-Wp-ALB]
  target_group_arns = ["${aws_lb_target_group.My-Wp-TG.arn}"]
  health_check_type = "EC2"
  launch_template {
    id      = aws_launch_template.wp-launch-template.id
    version = "$Latest"
  }
  vpc_zone_identifier = ["${aws_subnet.us_east_1a_priv.id}", "${aws_subnet.us_east_1b_priv.id}"]

  tag {
    key                 = "Name"
    value               = "My-Wp-ASG"
    propagate_at_launch = true
  }
}


# Create a scaling policy for scaling out (increasing instances) based on CPU utilization
resource "aws_autoscaling_policy" "scale_out_policy" {
  name                   = "scale-out-policy"
  autoscaling_group_name = aws_autoscaling_group.my_wp_auto_scaling.name
  policy_type            = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 1
  }
}



# Create CloudWatch alarms for scaling out and scaling in based on CPU utilization
resource "aws_cloudwatch_metric_alarm" "scale_out_alarm" {
  alarm_name          = "scale-out-alarm"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 60
  statistic           = "Average"
  threshold           = 1
  alarm_description   = "Scale out when CPU utilization is high"
  alarm_actions       = [aws_autoscaling_policy.scale_out_policy.arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.my_wp_auto_scaling.name
  }
}

