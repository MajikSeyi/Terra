#######################################
/*
RESOURCE GROUP AND VNET CREATION
only fill required value 
otherwise leave blank
*/
#######################################

existing_rg = "" #Only fill if you have an existing resource group else leave blank
new_rg      = ""

new_vnet      = ""
existing_vnet = "" #Only fill if you have an existing vnet else leave blank

#######################################
#SUBNET
#######################################

controller-subnet     = "" #Only fill if you have an existing controller subnet else leave blank
new-controller-subnet = ""

web-subnet     = "" #Only fill if you have an existing web subnet else leave blank
new-web-subnet = ""

db-subnet     = "" #Only fill if you have an existing db subnet else leave blank
new-db-subnet = ""


#######################################
#Network Interfaces
#######################################

controller-nic = "" #Example naming convention nebla-nic-controller-001
web-nic        = ""
db-nic         = ""


#######################################
/*
ADDRESS PREFIX
address_prefixes >> controller Prefix
address_prefixes2 >> web subnet prefix
address_prefixes3 >> db subnet prefix

*/
#######################################

address_prefixes  = [] #Example ["10.0.1.0/24"]
address_prefixes2 = []
address_prefixes3 = []

#######################################
#VIRTUAL MACHINE NAMES
#######################################

controller-vm-name = "" #Example Naming Convention ansible-controller
web-vm-name        = ""
db-vm-name         = ""