module "ecs" {
  source = "./ecs"
  public_subnets = module.vpc.public_subnets
  vpc_id = module.vpc.vpc_id
  ecs_execution_role_arn = module.iam.execution_role_arn
  ecs_cluster_name = "ecs-cluster-cicd"
  ecs_service_name = "app-cicd-service"
  capacity_provider = "FARGATE"
  cpu = 512
  memory = 1024
  image_uri = module.ecr.image_uri
  image_tag = "latest"
  container_name = "app-cicd-container"
  task_definition_name = "app-cicd-td"
  container_port = 3000
  host_port = 3000
}

module "vpc" {
  source = "./vpc"
  cidr_block_public_subnets = ["10.0.1.0/24","10.0.2.0/24"]
  cidr_block_vpc = "10.0.0.0/16"
  availability_zones = ["us-east-1a","us-east-1b"]
}

module "ecr" {
    source = "./ecr"
    ecr_repo_name = "repo_cicd_app"
}

module "iam" {
  source = "./iam"
}

module "codebuild" {
  source = "./codebuild"
  project_name = "cb-app-cicd"
  arn_codebuild_role = module.iam.arn_codebuild_role
  repository_uri = module.ecr.image_uri
  default_region = var.aws_default_region
  aws_account_id = var.aws_account_id
  image_repo_name = module.ecr.repo_name
  image_tag = "latest"
  container_name = "app-cicd-container"
  type_source = "GITHUB"
  repo_url = "https://github.com/brunodangelo/cicd_demo_aws.git"
  buildspec_file = "buildspec.yml"
}

module "codepipeline" {
  source = "./codepipeline"
  arn_codepipeline_role = module.iam.arn_codepipeline_role
  repo = "brunodangelo/cicd_demo_aws"
  branch = "main"
  bucket_name = "bucket-app-cicd-demo-bruno"
  project_name = module.codebuild.project_name
  cluster_name = module.ecs.ecs_cluster_name
  service_name = module.ecs.ecs_service_name
}