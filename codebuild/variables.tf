variable "project_name" {
  description = "Nombre del Proyecto de CodeBuild"
  type = string
}

variable "arn_codebuild_role" {
  description = "Rol de CodeBuild para acceder a ECR"
  type = string
}

variable "repository_uri" {
  description = "URI del repo en ECR"
  type = string
}

variable "default_region" {
  description = "Región de AWS donde realizar el proceso"
  type = string
}

variable "aws_account_id" {
  description = "ID de la cuenta de AWS"
  type = string
}

variable "image_repo_name" {
  description = "Nombre del repositorio en ECR donde se encuentran las imagenes de Docker"
  type = string
}

variable "image_tag" {
  description = "Etiqueta de la imagen en ECR"
  type = string
}

variable "container_name" {
  description = "Nombre del contenedor que se crea a partir de la imagen"
  type = string
}

variable "type_source" {
  description = "Plataforma utilizada para alamacenar el código fuente. (Por ej.: GITHUB)"
  type = string
}

variable "repo_url" {
  description = "URL del repositorio donde se encuentra el codigo fuente de la app"
  type = string
}

variable "buildspec_file" {
  description = "Nombre del archivo buildspec, que contiene las acciones a realizar por CodeBuild"
  type = string
}