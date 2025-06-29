variable "region" {
  description = "AWS Region"
  default     = "ap-south-1"
}

variable "instance_name" {
  description = "Name tag for EC2 instance"
  default     = "Devops-assignment"
}

variable "ami_id" {
  description = "AMI ID for Ubuntu"
  default     = "ami-0f918f7e67a3323f0"
}

variable "instance_type" {
  description = "EC2 instance type"
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name"
  default     = "Assignment"
}

variable "volume_size" {
  description = "Size of EBS volume in GB"
  default     = 10
}

variable "my_ip" {
  description = "My public IP address for connection"
  default = "152.58.2.25/32"
}


variable "stage" {
  description = "Deployment Stage"
  default     = "Dev"
}

