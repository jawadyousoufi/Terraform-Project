variable "region" {
  type        = string
  default     = "us-east-1"
}

variable "identifier" {
  type        = string
  default     = "rds-cluster"
}

variable "engine" {
  type        = string
  default     = "aurora-mysql"
}

variable "engine_version" {
  type        = string
  default     = "5.7.mysql_aurora.2.03.2"
}

variable "username" {
  type        = string
  default     = "team-1"
}

variable "publicly_accessible" {
  type        = bool
  default     = true
}

variable "master_password" {
  type        = string
  default     = "password123"
}

variable "db_subnet_group_name" {
  type        = string
  default     = "subnet-group1"
}

variable "vpc_sg_id" {
  type        = string
  default     = "sg-003c3722b4f68931f"
}



