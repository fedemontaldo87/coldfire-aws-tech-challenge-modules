variable "role_name" {
  description = "Nombre del rol IAM."
  type        = string
}

variable "role_path" {
  description = "Ruta del rol IAM."
  type        = string
  default     = "/"
}

variable "assume_role_index" {
  description = "Tipo de entidad que asumirá el rol (ej: EC2, LAMBDA, etc)."
  type        = string
  default     = "EC2"
}

variable "custom_policies" {
  description = "Lista de rutas a archivos JSON con políticas personalizadas. Los archivos deben estar en el directorio 'policies/' del módulo."
  type        = list(string)
  default     = []
}

variable "named_custom_policies" {
  description = "Lista de objetos con nombre y contenido de políticas custom. Cada objeto debe tener 'name' (string) y 'policy' (string, contenido JSON)."
  type = list(object({
    name   = string
    policy = string
  }))
  default = []
}

variable "policies_arn" {
  description = "Lista de ARNs de políticas gestionadas por AWS para adjuntar al rol."
  type        = list(string)
  default     = []
}

variable "create_role" {
  description = "Controla si se debe crear el rol IAM."
  type        = bool
  default     = true
}

variable "max_session_duration" {
  description = "Duración máxima de la sesión del rol en segundos (entre 3600 y 43200)."
  type        = number
  default     = 3600
  validation {
    condition     = var.max_session_duration >= 3600 && var.max_session_duration <= 43200
    error_message = "La duración máxima de la sesión debe estar entre 3600 y 43200 segundos."
  }
}

variable "environment" {
  description = "Ambiente (ej: dev, prod) para etiquetar los recursos."
  type        = string
}

variable "business_unit" {
  description = "Unidad de negocio para etiquetar los recursos."
  type        = string
}

variable "tags" {
  description = "Mapa de tags adicionales a aplicar a los recursos."
  type        = map(string)
  default     = {}
}

variable "external_id" {
  description = "ID externo opcional para trust policies cross-account."
  type        = string
  default     = ""
}

variable "trusted_services" {
  description = "Servicios AWS que pueden asumir el rol (ej: ec2.amazonaws.com)."
  type        = list(string)
  default     = ["ec2.amazonaws.com"]
}

variable "trusted_role_arns" {
  description = "Lista de ARNs de roles o usuarios que pueden asumir este rol (para confianza entre cuentas)."
  type        = list(string)
  default     = []
}

variable "region" {
  description = "Región de AWS"
  type        = string
}

variable "account_id" {
  description = "ID de cuenta AWS"
  type        = string
}

variable "inline_policy_json" {
  description = "Política inline en formato JSON string"
  type        = string
  default     = ""
}

