
# 🚀 Build & Push Docker Image Using Jenkins & GitHub Webhook

This project demonstrates a fully automated CI/CD workflow where Jenkins retrieves a Dockerfile from GitHub via a webhook trigger, builds a Docker image, and pushes it to Docker Hub using securely stored credentials. 


## 📌 Project Overview
Whenever we push code to this repository:

✔️ A GitHub Webhook triggers Jenkins

✔️ Jenkins pulls the latest code from the repository

✔️ Jenkins builds a Docker image using the provided Dockerfile

✔️ Jenkins logs in to Docker Hub using stored credentials

✔️ Jenkins pushes the Docker image to your Docker Hub repository


## 🏗️ Technologies Used

**Jenkins:** Automates the CI/CD pipeline

**GitHub Webhooks:** Automatically triggers Jenkins when new code is pushed.

**Docker & Docker Hub:** Builds containerized images and stores them in a remote registry. 

**Pipeline Script:** Defines the automated build and push process as code.

## 🔢 Prerequisites

✅ Jenkins Server Installed

✅ Docker Installed on Jenkins Host

✅ GitHub Repository

✅ Docker Hub Account

✅ Docker hub Credentials in Jenkins


# project steps

## 1. install java for jenkins

```bash
  sudo apt install openjdk-17-jdk -y

```
## 2. install jenkins
```bash
  sudo apt update
  sudo apt install jenkins -y

```
## 3. Start and enable Jenkins
```bash
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins

```
## 4. Access Jenkins

```bash
  http://YOUR_SERVER_IP:8080

```
## 5. Jenkins Credentials Setup 🔑 
now we need to add docker hub Credentials, to use it in pipeine.

➡️ Go to Jenkins Dashboard → Manage Jenkins → Credential  → Add a new credential:

- **Domain:** Global unrestricted
- **Kind:** Username wit Password
- **ID:** dockerhub_creds
- **Username:** Docker Hub username
- **Password:** Docker Hub Password

## 6. Create GitHub Webhook
webhook will trigger Jenkins on every push.

➡️ Go to your GitHub repository →
Navigate to Settings → Webhooks → Add Webhook

 ####  Payload URL:

    http://<jenkins-server>/github-webhook/


<img width="1652" height="982" alt="{39910A7C-5F0B-47CB-BF87-4AB24826BE9C}" src="https://github.com/user-attachments/assets/7d58f84b-551a-4041-a658-794e4b20d791" />



## 7. Create jenkins pipeine job


<img width="1885" height="859" alt="{D2D8A713-DF44-4576-B51A-0A0FCF106A4A}" src="https://github.com/user-attachments/assets/dee352d6-627a-4ed2-851f-30403d28b1e5" />




 
## 8. configure a pipleine

```jenkinsfile

pipeline{
    agent any
    stages {
        stage ("pull"){
            steps {
                git 'https://github.com/selva12543/jenkins-2.git'
            }
        }
        stage("building"){
            steps{
                 sh '''
                    echo "Building Docker image..."
                    docker build -t myimage:latest .
                '''
            }
        }
        stage("pushing_dockerhub"){
            steps{
                 withCredentials([usernamePassword(credentialsId: 'dockerhub_creds', passwordVariable: 'password', usernameVariable: 'username')]) {
            
                sh '''
                # docker login
                docker login -u $username -p $password
                # tagging 
                docker tag myimage:latest $username/myimage:latest
                # pushing to dockerhub
                docker push $username/myimage:latest
                
                '''
            }
            }
        }
    }
}
```

## 8. build job

<img width="447" height="655" alt="{B5246C7A-9D6C-4C1E-B62B-6D67CAC2B683}" src="https://github.com/user-attachments/assets/b978ac8f-02e7-41f0-a6d9-6ff4d31c4974" />



## 9. view Build result in Stage view

<img width="1882" height="474" alt="{A9D8AB99-4119-4C48-9028-1F6D23B1A9FF}" src="https://github.com/user-attachments/assets/8fa6fcdc-2407-4dc3-92e8-3f15f7241460" />


## 10. result 
 we can see the docker image in dockerhub that builded by jenkins.

<img width="1538" height="511" alt="{5437CE43-2FA0-4254-9ED7-9B2C6F3602EF}" src="https://github.com/user-attachments/assets/aafb64dc-09b5-4041-9949-2cbe96104701" />




Docker image appears in Docker Hub 🎉

## Lessons Learned

This project showcases an automated CI/CD pipeline where Jenkins, triggered by a GitHub webhook, builds a Docker image from the repository and securely pushes it to Docker Hub.

workflow:
 
➡️ Developer Pushes Code → GitHub Repository → Webhook Trigger → Jenkins Pulls Latest Code → Jenkins Builds Docker Image → Jenkins Logs Into Docker Hub → Jenkins Pushes Image to Docker Hub → Image Available for Deployment

