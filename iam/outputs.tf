output "execution_role_arn" {
  description = "ARN del execution Rol"
  value = aws_iam_role.ecs_execution_role.arn
}

output "arn_codebuild_role" {
  description = "Rol de CodeBuild para acceder a ECR"
  value = aws_iam_role.codebuild_role.arn
}

output "arn_codepipeline_role" {
  description = "Rol de CodePipeline"
  value = aws_iam_role.codepipeline_role.arn
}