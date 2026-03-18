variable "env" {
  description = "Environment name"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "azs_public" {
  description = "Availability zones for public subnets"
  type        = list(string)

  validation {
    condition     = length(var.azs_public) == length(var.public_subnets)
    error_message = "azs_public and public_subnets must have the same length."
  }
}

variable "azs_private" {
  description = "Availability zones for private subnets"
  type        = list(string)

  validation {
    condition     = length(var.azs_private) == length(var.private_subnets)
    error_message = "azs_private and private_subnets must have the same length."
  }
}

variable "public_subnets" {
  description = "CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets" {
  description = "CIDR blocks for private subnets"
  type        = list(string)
}

variable "enable_eks_tags" {
  description = "Whether to apply EKS subnet tags"
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "EKS cluster name for subnet tagging"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Common tags for all resources"
  type        = map(string)
  default     = {}
}