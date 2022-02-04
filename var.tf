variable "region" {
  type        = string
  description = "The region where the cluster is deployed"
  default     = "us-east-1"
}

variable "rds_cluster" {
  type        = string
  description = "The name of the rds cluster"
  default     = " Team1-"
}

variable "vpc_id" {
  type        = string
  description = "VPC of the db instances"
  default     = "default-vpc"
}