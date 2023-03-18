variable "region" {
  description = "region of the machine"
  default= "ap-south-1"
}

variable "availability_zone1" {
  description = "AZ 1st pref."
  default= "ap-south-1a"
}

variable "availability_zone2" {
  description = "AZ 2nd pref."
  default= "ap-south-1b"
}

variable "availability_zone3" {
  description = "AZ 3rd pref."
  default= "ap-south-1c"
}

variable "cidr_blockvpc" {
  description = "cidr of vpc"
  default = "10.0.0.0/16"
}

variable "cidr_blockpublic1" {
  description = "cidr of pub subnet"
  default = "10.0.1.0/24"
}

variable "cidr_blockpublic2" {
  description = "cidr of pub subnet"
  default = "10.0.2.0/24"
}


variable "cidr_blockprivate" {
  description = "cidr of private subnet"
  default = "10.0.3.0/24"
}

variable "cidr_blockprivate2" {
  description = "cidr of private subnet 2"
  default = "10.0.4.0/24"
}


variable "ami" {
  default = "ami-05afd67c4a44cc983"
}

variable "instance_type" {
  default = "t2.micro"

}

variable "username" {
  default = "adminuser"

}

variable "password" {
  default= "mypassword123"

}