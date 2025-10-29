# 🟦🟩 Blue-Green Deployment using Docker, Nginx, and GitHub Actions

## 📘 Overview
This project demonstrates a **Blue-Green Deployment** setup using:
- **Docker** for containerization  
- **Nginx** for traffic routing  
- **GitHub Actions** for automated CI/CD  
- **Docker Hub** for image hosting  

Whenever code is pushed to the `main` branch, GitHub Actions automatically:
1. Builds Docker images for both the Blue and Green versions.
2. Pushes them to Docker Hub.
3. Enables seamless switching between environments using Nginx.

---

## 🧱 Project Structure

flask-docker-ci/
├── app_blue/
├── app_green/
├── nginx/
├── docker-compose.yml
└── .github/workflows/deploy.yml

yaml
Copy code

---

## ⚙️ Setup Instructions

### 1️⃣ Clone Repository
```bash
git clone https://github.com/TilakManjunath/flask-docker-ci.git
cd flask-docker-ci
2️⃣ Configure GitHub Secrets
In your GitHub repo:

Go to Settings → Secrets and variables → Actions → New repository secret

Add:

DOCKERHUB_USERNAME → your Docker Hub username

DOCKERHUB_TOKEN → your Docker Hub access token

🚀 GitHub Actions Workflow
Each time you push to the main branch:

Blue and Green Docker images are built

Both are pushed to Docker Hub

You’ll see logs under Actions → Blue-Green Deployment

🧪 Run Locally
Step 1: Build and Start
bash
Copy code
docker-compose up --build
Step 2: Access
http://localhost → Nginx forwards traffic to the active version

http://localhost:5000 → Blue app

http://localhost:5001 → Green app

Step 3: Switch Traffic
In nginx/nginx.conf, comment out blue and enable green:

nginx
Copy code
# server app_blue:5000;
server app_green:5001;
Rebuild and restart:

bash
Copy code
docker-compose up --build
🧰 Tools Used
Flask — lightweight web framework

Docker — containerization

Nginx — reverse proxy

GitHub Actions — CI/CD automation

Docker Hub — image registry

🏁 Result
✅ Push code → GitHub Actions builds and pushes images
✅ Nginx routes traffic between Blue and Green versions
✅ Easy rollback or upgrade by switching environment