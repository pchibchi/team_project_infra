variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project_name" {
  description = "Project name"
  type        = string
}

variable "env" {
  description = "Environment name"
  type        = string
}

# -------------------------
# VPC
# -------------------------
variable "vpc_cidr" {
  description = "VPC CIDR block"
  type        = string
}

variable "azs_public" {
  description = "Availability zones for public subnets"
  type        = list(string)
}

variable "azs_private" {
  description = "Availability zones for private subnets"
  type        = list(string)
}

variable "public_subnets" {
  description = "Public subnet CIDRs"
  type        = list(string)
}

variable "private_subnets" {
  description = "Private subnet CIDRs"
  type        = list(string)
}

variable "enable_eks_tags" {
  description = "Enable EKS subnet tags"
  type        = bool
  default     = false
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = ""
}

# -------------------------
# RDS
# -------------------------
variable "db_identifier" {
  description = "RDS identifier suffix"
  type        = string
}

variable "db_name" {
  description = "Initial database name"
  type        = string
}

variable "db_engine" {
  description = "Database engine"
  type        = string
}

variable "db_engine_version" {
  description = "Database engine version"
  type        = string
}

variable "db_major_engine_version" {
  description = "Major engine version"
  type        = string
  default     = null
}

variable "db_instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "db_parameter_group_family" {
  description = "Parameter group family"
  type        = string
}

variable "db_username" {
  description = "Master username"
  type        = string
}

variable "db_password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "manage_master_user_password" {
  description = "Use AWS managed master password"
  type        = bool
  default     = false
}

variable "db_port" {
  description = "DB port"
  type        = number
  default     = 3306
}

variable "db_allocated_storage" {
  description = "Allocated storage"
  type        = number
}

variable "db_max_allocated_storage" {
  description = "Max allocated storage"
  type        = number
  default     = null
}

variable "db_storage_type" {
  description = "Storage type"
  type        = string
  default     = "gp3"
}

variable "db_iops" {
  description = "IOPS"
  type        = number
  default     = null
}

variable "db_storage_throughput" {
  description = "Storage throughput"
  type        = number
  default     = null
}

variable "db_storage_encrypted" {
  description = "Enable storage encryption"
  type        = bool
  default     = true
}

variable "db_kms_key_id" {
  description = "KMS key id"
  type        = string
  default     = null
}

variable "db_publicly_accessible" {
  description = "Publicly accessible"
  type        = bool
  default     = false
}

variable "db_multi_az" {
  description = "Enable multi AZ"
  type        = bool
  default     = false
}

variable "db_availability_zone" {
  description = "Preferred AZ"
  type        = string
  default     = null
}

variable "db_backup_retention_period" {
  description = "Backup retention period"
  type        = number
  default     = 7
}

variable "db_backup_window" {
  description = "Backup window"
  type        = string
  default     = null
}

variable "db_maintenance_window" {
  description = "Maintenance window"
  type        = string
  default     = null
}

variable "db_copy_tags_to_snapshot" {
  description = "Copy tags to snapshot"
  type        = bool
  default     = true
}

variable "db_delete_automated_backups" {
  description = "Delete automated backups on deletion"
  type        = bool
  default     = true
}

variable "db_deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "db_skip_final_snapshot" {
  description = "Skip final snapshot when deleting"
  type        = bool
  default     = true
}

variable "db_performance_insights_enabled" {
  description = "Enable performance insights"
  type        = bool
  default     = false
}

variable "db_performance_insights_retention_period" {
  description = "Performance insights retention period"
  type        = number
  default     = 7
}

variable "db_performance_insights_kms_key_id" {
  description = "KMS key for performance insights"
  type        = string
  default     = null
}

variable "db_monitoring_interval" {
  description = "Enhanced monitoring interval"
  type        = number
  default     = 0
}

variable "db_monitoring_role_arn" {
  description = "Monitoring role arn"
  type        = string
  default     = null
}

variable "db_enabled_cloudwatch_logs_exports" {
  description = "CloudWatch logs exports"
  type        = list(string)
  default     = []
}

variable "db_auto_minor_version_upgrade" {
  description = "Auto minor version upgrade"
  type        = bool
  default     = true
}

variable "db_allow_major_version_upgrade" {
  description = "Allow major version upgrade"
  type        = bool
  default     = false
}

variable "db_apply_immediately" {
  description = "Apply immediately"
  type        = bool
  default     = false
}

variable "db_ca_cert_identifier" {
  description = "CA cert identifier"
  type        = string
  default     = null
}

variable "db_license_model" {
  description = "License model"
  type        = string
  default     = null
}

variable "db_character_set_name" {
  description = "Character set name"
  type        = string
  default     = null
}

variable "db_allowed_cidr_blocks" {
  description = "Allowed CIDR blocks for DB access"
  type        = list(string)
  default     = []
}

variable "db_allowed_security_group_ids" {
  description = "Allowed security group IDs for DB access"
  type        = list(string)
  default     = []
}

variable "db_parameters" {
  description = "DB parameter group parameters"
  type = list(object({
    name         = string
    value        = string
    apply_method = optional(string)
  }))
  default = []
}

variable "db_create_option_group" {
  description = "Create option group"
  type        = bool
  default     = false
}

variable "db_options" {
  description = "Option group options"
  type = list(object({
    option_name = string
    port        = optional(number)
    version     = optional(string)
    option_settings = optional(list(object({
      name  = string
      value = string
    })))
  }))
  default = []
}


# -------------------------
# Bastion
# -------------------------
variable "bastion_instance_type" {
  description = "Bastion EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "bastion_key_name" {
  description = "EC2 key pair name for bastion"
  type        = string
}

variable "bastion_allowed_ssh_cidr_blocks" {
  description = "CIDR blocks allowed to SSH into bastion"
  type        = list(string)
}

# -------------------------
# EKS
# -------------------------
variable "eks_cluster_name" {
  description = "EKS cluster name suffix"
  type        = string
}

variable "eks_cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.31"
}

variable "eks_endpoint_private_access" {
  description = "Enable private access to EKS endpoint"
  type        = bool
  default     = true
}

variable "eks_endpoint_public_access" {
  description = "Enable public access to EKS endpoint"
  type        = bool
  default     = true
}

variable "eks_public_access_cidrs" {
  description = "Allowed public CIDRs for EKS endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "eks_capacity_type" {
  description = "EKS node group capacity type"
  type        = string
  default     = "ON_DEMAND"
}

variable "eks_instance_types" {
  description = "EKS node instance types"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "eks_ami_type" {
  description = "AMI type for EKS nodes"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "eks_disk_size" {
  description = "Disk size for EKS nodes"
  type        = number
  default     = 20
}

variable "eks_desired_size" {
  description = "Desired node count"
  type        = number
  default     = 2
}

variable "eks_min_size" {
  description = "Minimum node count"
  type        = number
  default     = 1
}

variable "eks_max_size" {
  description = "Maximum node count"
  type        = number
  default     = 3
}

variable "eks_max_unavailable" {
  description = "Max unavailable nodes during update"
  type        = number
  default     = 1
}

variable "eks_authentication_mode" {
  description = "EKS authentication mode"
  type        = string
  default     = "API_AND_CONFIG_MAP"
}

variable "eks_bootstrap_cluster_creator_admin_permissions" {
  description = "Grant cluster-admin to cluster creator"
  type        = bool
  default     = true
}

variable "eks_auto_mode_enabled" {
  description = "Enable EKS Auto Mode"
  type        = bool
  default     = false
}

# -------------------------
# ECR
# -------------------------
variable "ecr_repository_names" {
  description = "List of ECR repository names"
  type        = list(string)
}

variable "ecr_image_tag_mutability" {
  description = "ECR image tag mutability"
  type        = string
  default     = "MUTABLE"
}

variable "ecr_scan_on_push" {
  description = "Enable ECR image scan on push"
  type        = bool
  default     = true
}

variable "ecr_force_delete" {
  description = "Force delete ECR repositories even if images exist"
  type        = bool
  default     = false
}

variable "ecr_encryption_type" {
  description = "ECR encryption type"
  type        = string
  default     = "AES256"
}

variable "ecr_kms_key_arn" {
  description = "KMS key ARN for ECR encryption"
  type        = string
  default     = null
}

variable "ecr_create_lifecycle_policy" {
  description = "Whether to create ECR lifecycle policy"
  type        = bool
  default     = true
}

variable "ecr_lifecycle_policy" {
  description = "Lifecycle policy JSON string for ECR"
  type        = string
  default     = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "Keep last 10 images",
      "selection": {
        "tagStatus": "any",
        "countType": "imageCountMoreThan",
        "countNumber": 10
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}