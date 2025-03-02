variable "ami" {
  description = "ID of AMI to use for the c2 instance."
  type        = string
}

variable "instance_type" {
    description = "Size of the c2 instance."
    type        = string
}

variable "c2_redirector_sg_id" {
    description = "Security group handling traffic for the C2 redirector."
    type        = string
}