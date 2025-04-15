resource "aws_codebuild_project" "codebuild_project" {
  name          = var.project_name
  description   = "Code Build para la app de CICD"
  build_timeout = 15
  service_role  = var.arn_codebuild_role

  artifacts {
    type = "NO_ARTIFACTS"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode = "true"

    environment_variable {
      name  = "AWS_DEFAULT_REGION"
      value = var.default_region
    }

    environment_variable {
      name  = "AWS_ACCOUNT_ID"
      value = var.aws_account_id
    }

    environment_variable {
      name  = "IMAGE_REPO_NAME"
      value = var.image_repo_name
    }

    environment_variable {
      name  = "REPOSITORY_URI"
      value = var.repository_uri
    }

    environment_variable {
      name  = "IMAGE_TAG"
      value = var.image_tag
    }

    environment_variable {
      name  = "CONTAINER_NAME"
      value = var.container_name
    }
  }

  source {
    type            = var.type_source
    location        = var.repo_url
    git_clone_depth = 1
    buildspec = var.buildspec_file
  }

  tags = {
    Owner = "Bruno"
  }
}