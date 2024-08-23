# Containerized Static Website with CI/CD on AWS

## Project Overview

This project demonstrates how to deploy a static website using Amazon S3 and AWS Amplify and integrate it with a containerized service using Docker and AWS Fargate. The setup includes CI/CD pipelines for automated deployment and management.

## Architecture

- **Amazon S3:** Hosts the static website.
- **AWS Amplify:** Manages the CI/CD pipeline and provides additional integrations.
- **Docker:** Containerizes the service.
- **AWS Fargate:** Runs the Docker containerized service.
- **Amazon ECS:** Manages the containerized service in the cluster.
- **Amazon ECR:** Stores the Docker images for the service.

## Prerequisites

- AWS account
- Knowledge of AWS services
- Docker installed
- AWS CLI installed
- GitHub repository (for CI/CD integration)

## Project Setup

### Step 1: Prepare Your Static Website

1. **Create Static Website Files:**
   - `index.html`
   - `style.css`

2. **Upload Files to Amazon S3:**
   - **Log in to AWS Management Console** and navigate to [Amazon S3].
   - **Create a New S3 Bucket:**
     - Click “Create bucket” and follow the prompts to create a bucket (e.g., `my-static-website-bucket`).
   - **Upload Static Website Files:**
     - Go to the created bucket, click “Upload,” and upload your `index.html` and `style.css` files.
   - **Configure Bucket for Static Website Hosting:**
     - Go to the bucket’s **Properties** tab.
     - Scroll to the **Static website hosting** section and enable it.
     - Specify `index.html` as the index document and `error.html` if applicable.

### Step 2: Deploy Using AWS Amplify (Optional)

1. **Log in to AWS Amplify Console:**
   - Navigate to the [AWS Amplify Console].
2. **Create a New Amplify App:**
   - Click on "Get Started" under "Deploy."
   - Connect your GitHub repository 

3. **Configure Build Settings:**
   - AWS Amplify will auto-detect build settings for static sites. Review and save settings.

4. **Deploy Your Website:**
   - Amplify will automatically deploy your static website. Monitor the deployment process.

### Step 3: Containerize Your Service Using Docker

1. **Create a Dockerfile:**
   - Write a `Dockerfile` for your service. For example:
     ```Dockerfile
     # Use an official base image
     FROM nginx:alpine

     # Copy static content to the container
     COPY ./html /usr/share/nginx/html

     # Expose port
     EXPOSE 80

     # Command to run the service
     CMD ["nginx", "-g", "daemon off;"]
     ```

2. **Build the Docker Image:**
   - Run the following command to build your Docker image:
     ```bash
     docker build -t my-web-service .
     ```

3. **Push the Docker Image to Amazon ECR:**
   - **Create an ECR Repository:**
     - In the AWS Management Console, go to [Amazon ECR]and create a new repository.
   - **Authenticate Docker to ECR:**
     ```bash
     aws ecr get-login-password --region <region> | docker login --username AWS --password-stdin <account-id>.dkr.ecr.<region>.amazonaws.com
     ```
   - **Tag and Push the Docker Image:**
     ```bash
     docker tag my-web-service:latest <account-id>.dkr.ecr.<region>.amazonaws.com/my-web-service:latest
     docker push <account-id>.dkr.ecr.<region>.amazonaws.com/my-web-service:latest
     ```

### Step 4: Deploy Containerized Service Using AWS Fargate

1. **Create an ECS Cluster:**
   - Navigate to [Amazon ECS].
   - Click on “Create Cluster” and select “Networking only” (Fargate).

2. **Create a Task Definition:**
   - Go to “Task Definitions” and click “Create new Task Definition.”
   - Choose “Fargate” as the launch type.
   - Specify the Docker image URI from ECR.

3. **Create a Service:**
   - In your ECS cluster, go to the “Services” tab.
   - Click “Create” and configure your service to use the task definition you created.

4. **Deploy the Service:**
   - ECS will manage the deployment of your containerized service.

### Step 5: Integrate AWS Amplify with Your ECS Service

1. **Update Environment Variables:**
   - In AWS Amplify, go to **Environment variables**.
   - Add any necessary environment variables required by your ECS service.

2. **Configure Custom Domains (if needed):**
   - Go to **Domain management** in Amplify.
   - Set up DNS records to point to your ECS service or use a load balancer.

3. **Update Build Settings (if needed):**
   - Update the `amplify.yml` file in your Amplify app to include any required build commands or scripts.

### Step 6: Test and Monitor

1. **Push Changes to GitHub:**
   - Make changes to your static site or containerized service and push them to your GitHub repository.

2. **Monitor Deployments:**
   - Check AWS Amplify and ECS for deployment statuses and logs.

3. **Troubleshoot Issues:**
   - Use CloudWatch logs to diagnose and troubleshoot any issues with the integrations.

## Conclusion

This project showcases the integration of Amazon S3 for static site hosting with Docker containerization and AWS Fargate for running containerized services, demonstrating a complete CI/CD workflow in AWS.

