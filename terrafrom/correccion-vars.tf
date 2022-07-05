variable "location" {
  type        = string
  description = "Región de Azure donde crearemos la infraestructura"
  default     = "uksouth"
}

variable "public_key_path" {
  type        = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default     = "~/.ssh/id_rsa.pub"
}

variable "ssh_user" {
  type        = string
  description = "Usuario para hacer ssh"
  default     = "adminUserVm"
}

variable "tags_all_resources" {
  description = "Tags para todos los recursos"
  type        = map(string)
  default = {
    environment = "cp2"
  }
}

variable "vm_master_size" {
  type        = string
  description = "Tamaño de la máquina virtual para el nodo master"
  default     = "Standard_D2_v3" # 2 CPU Cores, 8GB Memory
}

variable "vm_worker_size" {
  type        = string
  description = "Tamaño de la máquina virtual para los nodos workers"
  default     = "Standard_F2" # 2 CPU Core, 4GB Memory
}

variable "vm_nfs_size" {
  type        = string
  description = "Tamaño de la máquina virtual para el nodo nfs"
  default     = "Standard_DS1_v2" # 1 CPU Core, 3.5GB Memory
}

variable "vm_worker_names" {
  type        = list(string)
  description = "Nombres y cantidad de workers de Kubernetes"
  default     = ["worker-node-1"]
}

variable "network_name" {
  default = "vnet-cp2"
}

variable "subnet_name" {
  default = "subnet-cp2"
}

variable "nic_name" {
  default = "nic-cp2"
}

variable "ingress_controller_port" {
  description = "Puerto para IngressController"
  type        = number
  default     = 30153
}