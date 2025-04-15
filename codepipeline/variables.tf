variable "arn_codepipeline_role" {
  description = "ARN del Rol de CodePipeline"
  type = string
}

variable "repo" {
  description = "Organización / Repositorio"
  type = string
}

variable "branch" {
  description = "Rama en el repositorio"
  type = string
}

variable "bucket_name" {
  description = "Nombre del bucket S3 para almacenar los artefactos"
  type = string
}

variable "project_name" {
  description = "Nombre del proyecto para la etapa de Build"
  type = string
}

variable "cluster_name" {
  description = "Nombre del cluster en ECS donde se despliegan las tareas"
  type = string
}

variable "service_name" {
  description = "Nombre del servicio en ECS"
  type = string
}