variable "vpc-fullcidr" {
    default = "172.28.0.0/16"
  description = "the vpc cdir"
}
variable "Subnet-Public" {
  default = "172.28.0.0/24"
  description = "the cidr of the subnet"
}
variable "Subnet-Private" {
  default = "172.28.3.0/24"
  description = "the cidr of the subnet"
}
variable "key_name" {
  default = "sokolov-key"
  description = "the ssh key to use in the EC2 machines"
}
variable "DnsZoneName" {
  default = "example.internal"
  description = "the internal dns name"
}
#variable "web_elb"{}


