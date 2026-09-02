resource "aws_cloudwatch_metric_alarm" "cpu_alarm" {
  alarm_name          = "ec2-high-cpu-utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions = [
    aws_sns_topic.alerts.arn
  ]
  dimensions = {
    InstanceId = var.instance_id
  }
}
resource "aws_sns_topic" "alerts" {
  name = "website-cloudwatch-alerts"
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.alerts.arn
  protocol  = "email"
  endpoint   = var.alert_email
}
resource "aws_cloudwatch_dashboard" "main" {
  dashboard_name = "website-health"

  dashboard_body = jsonencode({
    widgets = [
      {
        type   = "metric"
        x      = 0
        y      = 0
        width  = 12
        height = 6
        properties = {
          metrics = [
            [ "AWS/EC2", "CPUUtilization", "InstanceId", var.instance_id ]
          ]
          period = 10
          stat   = "Average"
          region = "us-east-1"
          title  = "EC2 Instance CPU"
        }
      }
    ]
  })
}
