variable "namespace" {
  description = "The project namespace for resource naming"
  default     = "threetier"
}
variable "region" {
  description = "AWS region"
  default     = "us-east-1"
}
variable "ssh_keypair" {
  description = "SSH keypair to use for autoscaling"
  default     = null
  type        = string
}
variable "cluster_engine" {
  description = "Aurora cluster engine"
  type        = string
  default     = "MySQL"
}
variable "zone_id" {
  description = "Hosted zone ID for Route53"
  type = string
  default = "Z0476029QV6CFASX3NJT"
}
