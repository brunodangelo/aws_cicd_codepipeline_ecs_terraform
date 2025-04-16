resource "aws_codestarconnections_connection" "github-connection" {
  name          = "github-connection-bruno"
  provider_type = "GitHub"
}

resource "aws_s3_bucket" "artifact_store" {
    bucket = var.bucket_name
}

resource "aws_codepipeline" "pipeline" {
  name     = "app-cicd-pipeline"
  role_arn = var.arn_codepipeline_role
  pipeline_type = "V2"
  execution_mode = "SUPERSEDED"

  artifact_store {
    type     = "S3"
    location = aws_s3_bucket.artifact_store.bucket
  }

  stage {
    name = "Source"
    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]
      configuration = {
        ConnectionArn    = aws_codestarconnections_connection.github-connection.arn
        FullRepositoryId = var.repo
        BranchName       = var.branch
        DetectChanges = "true"
      }
    }
  }

  stage {
    name = "Build"
    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      version          = "1"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      configuration = {
        ProjectName = var.project_name
      }
    }
  }

  stage {
    name = "Deploy"
    action {
      name             = "Deploy"
      category         = "Deploy"
      owner            = "AWS"
      provider         = "ECS"
      version          = "1"
      input_artifacts  = ["build_output"]
      configuration = {
        ClusterName = var.cluster_name
        ServiceName = var.service_name
      }
    }
  }

  tags = {
    Owner = "Bruno"
    App_name = "CICD-APP"
  }
}
