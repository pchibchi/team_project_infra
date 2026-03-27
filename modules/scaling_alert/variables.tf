variable "env" {
  type = string
}

variable "cluster_name" {
  type = string
}

variable "mng_asg_name" {
  description = "ASG name for scaling_alert"
  type        = string
}

variable "alert_email" {
  description = "Email address for scaling alerts"
  type        = string
}
