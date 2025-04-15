output "project_name" {
  description = "Nombre del proyecto de CodeBuild"
  value = aws_codebuild_project.codebuild_project.name
}