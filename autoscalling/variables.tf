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