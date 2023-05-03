output "alarm_actions" {
  value = aws_cloudwatch_event_target.lambda_trigger_target.arn
}