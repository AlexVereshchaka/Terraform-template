output "aws_cloudwatch_metric_alarm_high" {
  value = aws_cloudwatch_metric_alarm.cpu_usage_high.alarm_name
}

output "aws_cloudwatch_metric_alarm_low" {
value = aws_cloudwatch_metric_alarm.cpu_usage_low.alarm_name
}
