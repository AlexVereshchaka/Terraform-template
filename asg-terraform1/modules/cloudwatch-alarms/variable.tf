/* variable "alarm_actions" {
   description = "The list of actions to execute when this alarm transitions into an ALARM state"
  type        = list(string)
  default     = ["${molule.aws_lambda_function.main.arn}"] 
} */


variable "alarm_name_high" {

}

variable "alarm_actions" {
  
}

variable "threshold" {

}

variable "aws_instance_id" {
  
}

variable "period" {
}

variable "namespace" {
  type = string
}

variable "metric_name" {
  type = string
}


/* variable "ok_actions" {
  type = list(string)
} */

variable "alarm_threshold" {
  type = number
}

variable "evaluation_periods" {
  type = number
}

variable "comparison_operator_l" {
  type = string
}

variable "comparison_operator_h" {
  
}


