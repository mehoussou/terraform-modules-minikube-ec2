variable "vpc_cidr" {
  description = "This is the cidr range for your VPC"
  default     = "172.16.0.0/16"
}
variable "env" {
  description = "Environment name"
  default     = "Development"
}
variable "public-subnet-cidr-a" {
    description = "The cidr range for public subnet a"
    default = "172.16.0.0/24"
}
variable "public-subnet-cidr-b" {
    description = "The cidr range for public subnet b"
    default = "172.16.1.0/24"
}
variable "public-subnet-cidr-c" {
    description = "The cidr range for public subnet c"
    default = "172.16.2.0/24"
}
variable "private-subnet-cidr-a" {
    description = "The cidr range for private subnet a"
    default = "172.16.3.0/24"
}
variable "private-subnet-cidr-b" {
    description = "The cidr range for private subnet b"
    default = "172.16.4.0/24"
}
variable "private-subnet-cidr-c" {
    description = "The cidr range for private subnet c"
    default = "172.16.5.0/24"
}
variable "my-ip" {
    description = "Your home IP address"
    default = "174.51.57.8"
}
