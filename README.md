# aws_cicd_codepipeline_ecs_terraform
Despliegue de Aplicación con ECS Fargate, utilizando CICD con CodePipeline y CodeBuild. Infraestructura como Código con Terraform.

### Architecture / Arquitectura
![arquitectura cicd ecs aws](https://github.com/user-attachments/assets/72fcaddf-fd8a-4831-ab47-4e3d0dcfa142)

### Resources / Recursos
* 1 ECS Cluster
* 1 ECS Service
* 1 ECR repository
* 1 CodePipeline
* 1 CodeBuild
* 2 Auto Scaling groups
* 1 Load Balancer
* 1 Targets groups
* 1 LB Listeners
* 2 App Auto Scaling policies
* 2 CloudWatch Alarm
* 1 VPC
* 2 Public Subnets
* 1 Internet Gateway
* 1 S3 bucket
* IAM policies

### Notes / Notas

* (English): Add your aws account_id in the variables.tf AND authorize the connection to GitHub (follow the screenshots steps bellow).

* (Español): Agregar el aws account_id en el archivos variables.tf Y autoriza la conexión a GitHub (Seguí los pasos de abajo)

### Connection to GitHub / Conexión a GitHub en AWS

  ![Captura de pantalla 2025-04-15 113717](https://github.com/user-attachments/assets/68e8d93a-d867-4961-b555-2f8c6106f77f)
  ![Captura de pantalla 2025-04-15 192018](https://github.com/user-attachments/assets/6cd27796-e7c9-4525-be24-9d4f5b971223)
  ![Captura de pantalla 2025-04-15 113747](https://github.com/user-attachments/assets/03e7bc83-1927-423d-93b0-6812352553eb)

### Commands / Comandos

```
terraform init
```

```
terraform plan
```

```
terraform apply
```

