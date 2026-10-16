# 🚀 Website Automation — End-to-End DevOps Project

<p align="center">
  <b>Automating website deployment with Jenkins, Docker, Docker Hub, Terraform and AWS</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/AWS-Cloud-orange?logo=amazonaws" alt="AWS"/>
  <img src="https://img.shields.io/badge/Terraform-IaC-844FBA?logo=terraform" alt="Terraform"/>
  <img src="https://img.shields.io/badge/Jenkins-CI%2FCD-D24939?logo=jenkins" alt="Jenkins"/>
  <img src="https://img.shields.io/badge/Docker-Containers-2496ED?logo=docker" alt="Docker"/>
  <img src="https://img.shields.io/badge/Nginx-Web%20Server-009639?logo=nginx" alt="Nginx"/>
</p>

<p align="center">
  <a href="#-project-overview">Overview</a> •
  <a href="#-architecture">Architecture</a> •
  <a href="#-project-structure">Structure</a> •
  <a href="#-deployment-workflow">Workflow</a> •
  <a href="#-setup-and-execution">Setup</a>
</p>

---

## 📌 Project Overview

**Website Automation** is a hands-on DevOps project that combines Infrastructure as Code (IaC), CI/CD, containerization, and AWS cloud infrastructure to automate the deployment of a static HTML website.

The website is packaged into a Docker image, pushed to Docker Hub through a Jenkins pipeline, and served using Nginx on an AWS EC2 instance.

Terraform manages the AWS infrastructure, while an Amazon S3 bucket stores Terraform's remote state.

### 🎯 Project objectives

- Automate AWS infrastructure provisioning using Terraform.
- Build a Docker image for an HTML website served by Nginx.
- Push container images to Docker Hub using Jenkins.
- Provision AWS resources through reusable Terraform modules.
- Maintain Terraform state in an S3 remote backend.
- Configure CloudWatch monitoring for the EC2 instance.
- Practice a repeatable, version-controlled DevOps workflow.

## 🏗️ Architecture

The project combines two related workflows: **application containerization** and **infrastructure provisioning**.

```mermaid
flowchart TD
    DEV["Developer"] --> GIT["GitHub Repository"]
    GIT --> JENKINS["Jenkins Pipeline"]

    subgraph APP["Application Delivery"]
        JENKINS --> BUILD["Docker Build"]
        BUILD --> IMAGE["Website Docker Image"]
        IMAGE --> HUB["Docker Hub Registry"]
        HUB --> EC2["AWS EC2 Instance"]
        EC2 --> NGINX["Nginx Container"]
        NGINX --> HTML["HTML Website"]
        USER["Website Visitor"] --> NGINX
    end

    subgraph INFRA["Infrastructure Provisioning"]
        JENKINS --> TF["Terraform"]
        TF --> S3["Amazon S3 Remote State"]
        TF --> VPC["VPC and Security Group"]
        VPC --> INSTANCE["EC2 Infrastructure"]
        TF --> CW["CloudWatch Monitoring"]
        INSTANCE --> CW
    end
```

<details>
<summary><b>🔍 How the architecture works</b></summary>

1. **GitHub:** Stores the source code, Dockerfile, Terraform configuration, and Jenkins pipeline.
2. **Jenkins:** Executes the configured pipeline stages.
3. **Docker:** Builds an image containing the website and its Nginx configuration.
4. **Docker Hub:** Stores the published container image.
5. **Terraform:** Provisions and manages AWS infrastructure.
6. **Amazon S3:** Stores the Terraform state file remotely.
7. **Amazon EC2:** Provides the compute environment for hosting the container.
8. **Nginx:** Serves the HTML page over HTTP.
9. **Amazon CloudWatch:** Supports instance monitoring and configured alerts.

The application deployment and Terraform provisioning are separate responsibilities, even though Jenkins can orchestrate both.

</details>

## 🛠️ Technologies Used

| Technology | Role in this project |
|---|---|
| AWS
