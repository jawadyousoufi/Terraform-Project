variable "namespace" {
  type = string
  default = "aws_launch_template"
}
variable "ssh_keypair" {
  type = string
}
variable "vpc" {
    type = any
}
variable "sg" {
  type = any
}

variable "vpc-id" {
  default = "vpc-0efe5dfa1ccfd74d0"
}