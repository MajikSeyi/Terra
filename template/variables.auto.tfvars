#######################################
/*
RESOURCE GROUP AND VNET CREATION
only fill required value 
otherwise leave blank
*/
#######################################

existing_rg = "" #Only fill if you have an existing resource group else leave blank
new_rg      = "mayoransible"

new_vnet      = "Ansible"
existing_vnet = "" #Only fill if you have an existing vnet else leave blank

#######################################
#SUBNET
#######################################

controller-subnet     = "" #Only fill if you have an existing controller subnet else leave blank
new-controller-subnet = "control"

web-subnet     = "" #Only fill if you have an existing web subnet else leave blank
new-web-subnet = "websubnet"

db-subnet     = "" #Only fill if you have an existing db subnet else leave blank
new-db-subnet = "DB-subnet"


#######################################
#Network Interfaces
#######################################

controller-nic = "nic-control" #Example naming convention nebla-nic-controller-001
web-nic        = "nic-web"
db-nic         = "nic-db"


#######################################
/*
ADDRESS PREFIX
address_prefixes >> controller Prefix
address_prefixes2 >> web subnet prefix
address_prefixes3 >> db subnet prefix

*/
#######################################

address_prefixes  = [10.0.1.0/24] #Example ["10.0.1.0/24"]
address_prefixes2 = [10.0.2.0/24]
address_prefixes3 = [10.0.3.0/24]

#######################################
#VIRTUAL MACHINE NAMES
#######################################

controller-vm-name = "ansible-controller" #Example Naming Convention ansible-controller
web-vm-name        = "web-controller"
db-vm-name         = "db-controller"