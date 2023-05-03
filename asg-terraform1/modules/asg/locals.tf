/* locals {
  launch_template_arns = [for ami_id in var.ami_ids : aws_launch_template.example[2].arn]
} */


locals {
  launch_template_arn = aws_launch_template.example[0].arn
}
