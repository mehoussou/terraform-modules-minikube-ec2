variable "vpc_cidr" {
  description = "This is the cidr range for your VPC"
}
variable "env" {
  description = "Environment name"
}
variable "public-subnet-cidr-a" {
    description = "The cidr range for public subnet a"
}
variable "public-subnet-cidr-b" {
    description = "The cidr range for public subnet b"
}
variable "public-subnet-cidr-c" {
    description = "The cidr range for public subnet c"
}
variable "private-subnet-cidr-a" {
    description = "The cidr range for private subnet a"
}
variable "private-subnet-cidr-b" {
    description = "The cidr range for private subnet b"
}
variable "private-subnet-cidr-c" {
    description = "The cidr range for private subnet c"
}
