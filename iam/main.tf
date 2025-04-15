#Execution Role para las task en ECS
resource "aws_iam_role" "ecs_execution_role" {
    name = "ecsTaskExecRole"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
        Effect = "Allow"
        Principal = {
            Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
        }]
    })
}

resource "aws_iam_policy_attachment" "ecs_execution_role_policy" {
    name       = "ecs_execution_role_policy"
    roles      = [aws_iam_role.ecs_execution_role.name]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

#Rol para CodeBuild
resource "aws_iam_role" "codebuild_role" {
    name = "CodeBuildRole"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
        Effect = "Allow"
        Principal = {
            Service = "codebuild.amazonaws.com"
        }
        Action = "sts:AssumeRole"
        }]
    })
}

resource "aws_iam_policy" "codebuild_policy" {
    name        = "CodeBuildPolicy"
    description = "Permitir acceso de Code Build a ECR"
    policy      = jsonencode({
        Version = "2012-10-17"
        Statement = [
        # Permisos para ECR
        {
            Effect = "Allow"
            Action = [
            "ecr:BatchCheckLayerAvailability",
            "ecr:CompleteLayerUpload",
            "ecr:GetAuthorizationToken",
            "ecr:InitiateLayerUpload",
            "ecr:PutImage",
            "ecr:UploadLayerPart"
            ]
            Resource = "*"
        },
        {
            Effect = "Allow"
            Action = [
                "logs:CreateLogStream",
                "logs:CreateLogGroup",
                "logs:PutLogEvents"
            ]
            Resource = "*"
        },
        {
            Effect = "Allow"
            Action = [
                "s3:GetObject",
                "s3:PutObject",
            ]
            Resource = "*"
        }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "codebuild_role_attachment" {
    role       = aws_iam_role.codebuild_role.name
    policy_arn = aws_iam_policy.codebuild_policy.arn
}

#Rol para CodePipeline
resource "aws_iam_role" "codepipeline_role" {
    name = "CodePipelineRole"

    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [{
        Effect = "Allow"
        Principal = {
            Service = "codepipeline.amazonaws.com"
        }
        Action = "sts:AssumeRole"
        }]
    })
}

resource "aws_iam_policy" "codepipeline_policy" {
    name        = "CodePipelinePolicy"
    description = "Permitir acceso de CodePipeline a S3, CodeBuild, ECS y CodeConnection"
    policy      = jsonencode({
        Version = "2012-10-17"
        Statement = [
        # Permisos para CodeBuild
        {
            "Action": [
                "codebuild:BatchGetBuilds",
                "codebuild:StartBuild",
                "codebuild:BatchGetBuildBatches",
                "codebuild:StartBuildBatch"
            ],
            "Resource": [
                "*"
            ],
            "Effect": "Allow"
        },
        {
            "Sid": "AllowS3BucketAccess",
            "Effect": "Allow",
            "Action": [
                "s3:GetBucketVersioning",
                "s3:GetBucketAcl",
                "s3:GetBucketLocation"
            ],
            "Resource": [
                "*"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:ResourceAccount": "742368616637"
                }
            }
        },
        {
            "Sid": "AllowS3ObjectAccess",
            "Effect": "Allow",
            "Action": [
                "s3:PutObject",
                "s3:PutObjectAcl",
                "s3:GetObject",
                "s3:GetObjectVersion"
            ],
            "Resource": [
                "*"
            ],
            "Condition": {
                "StringEquals": {
                    "aws:ResourceAccount": "742368616637"
                }
            }
        },
        {
            "Effect": "Allow",
            "Action": [
                "codeconnections:UseConnection",
                "codestar-connections:UseConnection"
            ],
            "Resource": ["*"]
        },
        {
            "Sid": "TaskDefinitionPermissions",
            "Effect": "Allow",
            "Action": [
                "ecs:DescribeTaskDefinition",
                "ecs:RegisterTaskDefinition"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "ECSServicePermissions",
            "Effect": "Allow",
            "Action": [
                "ecs:DescribeServices",
                "ecs:UpdateService"
            ],
            "Resource": [
                "*"
            ]
        },
        {
            "Sid": "ECSTagResource",
            "Effect": "Allow",
            "Action": [
                "ecs:TagResource"
            ],
            "Resource": [
                "*"
            ],
            "Condition": {
                "StringEquals": {
                    "ecs:CreateAction": [
                        "RegisterTaskDefinition"
                    ]
                }
            }
        },
        {
            "Sid": "IamPassRolePermissions",
            "Effect": "Allow",
            "Action": "iam:PassRole",
            "Resource": [
                "*"
            ],
            "Condition": {
                "StringEquals": {
                    "iam:PassedToService": [
                        "ecs.amazonaws.com",
                        "ecs-tasks.amazonaws.com"
                    ]
                }
            }
        }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "codepipeline_role_attachment" {
    role       = aws_iam_role.codepipeline_role.name
    policy_arn = aws_iam_policy.codepipeline_policy.arn
}
