# optimo
optimo capital interview 

# Optimo Deployment Guide

## Local Development

1. Clone the repo:  
   `git clone https://github.com/your-org/optimo.git`  
2. Enter directory:  
   `cd optimo`  
3. Start containers:  
   `docker-compose up -d`

## AWS Deployment

1. Setup infrastructure: 
   ### IMP - make sure to create you .pem key on the aws and make sure to edit you main.tf file with this .pem key 
   `cd terraform && terraform init`
   `terrafrom plan`
   `terrafrom apply`
   ### If you would like to destroy the resources
   `terraform destroy`  
2. SSH to EC2:  
   `ssh -i key.pem ubuntu@EC2_IP`  
3. On EC2:  
   ```
   git clone https://github.com/your-org/optimo.git
   cd optimo
   docker-compose -f docker-compose.yml up -d
   ```

## CI/CD
Automatic deployment on git push to main branch

Auto-rollback if health checks fail

## Access
App: http://EC2_IP:3000

API: http://EC2_IP:8000

Monitoring: http://EC2_IP:9090 (Prometheus)

## Basic Commands
```
# View logs
docker-compose logs

# Restart services
docker-compose restart

# Update deployment
git pull && docker-compose up -d --build
```


