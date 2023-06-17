##RESOURCE GROUP
variable "new_rg" {
  type        = string
  description = "The name of the RG"
  default     = null
}

variable "existing_rg" {
  type        = string
  description = "The name of the RG"
  default     = ""
}

variable "location" {
  type    = string
  default = "South Central US"
}

##VIRTUAL NETWORK
variable "existing_vnet" {
  type    = string
  default = ""
}

variable "new_vnet" {
  type    = string
  default = ""
}

#SUBNETS

variable "controller-subnet" {
  type    = string
  default = ""
}

variable "web-subnet" {
  type    = string
  default = ""
}

variable "db-subnet" {
  type    = string
  default = ""
}

variable "new-controller-subnet" {
  type    = string
  default = ""
}

variable "new-web-subnet" {
  type    = string
  default = ""
}

variable "new-db-subnet" {
  type    = string
  default = ""
}

##address prefix
variable "address_prefixes" {
  type = list(string)
}

variable "address_prefixes2" {
  type = list(string)
}

variable "address_prefixes3" {
  type = list(string)
}

##NETWORK INTERFACES
variable "controller-nic" {
  type    = string
  default = ""

}

variable "web-nic" {
  type    = string
  default = ""
}

variable "db-nic" {
  type    = string
  default = ""
}


## VM NAME
variable "controller-vm-name" {
  type    = string
  default = ""
}

variable "web-vm-name" {
  type    = string
  default = ""
}

variable "db-vm-name" {
  type    = string
  default = ""
}

#CREDENTIALS

variable "user-name" {
  type    = string
  default = "ansible"
}

variable "password" {
  type    = string
  default = "Ansible12354$"
}

