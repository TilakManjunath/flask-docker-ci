# Auto-build & push Docker image with GitHub Actions

This mini-project demonstrates automated container image building and pushing using **GitHub Actions**, **Docker**, and **Docker Hub**.  
It containerizes a simple Flask app and automatically builds & pushes the image whenever code is pushed to the `main` branch (and optionally when you create Git tags).

---

## Project structure

project-root/
│
├── app.py
├── Dockerfile
├── docker-compose.yml # optional
├── .github/
│ └── workflows/
│ └── docker-build-push.yml
└── README.md

---

## Files explained

- **`app.py`** - Minimal Flask app that responds with `Hello from GitHub Actions!` on `/` (port 5000).
- **`Dockerfile`** - Builds a lightweight container image using `python:3.11-slim`, installs Flask, copies `app.py`, and runs it.
- **`.github/workflows/docker-build-push.yml`** - GitHub Actions workflow that:
  - Triggers on push to `main` and on tags matching `v*`.
  - Logs in to Docker Hub using repository secrets.
  - Builds & pushes the Docker image as `<DOCKERHUB_USERNAME>/<repo-name>:latest`.
  - When you push a Git tag (e.g., `v1.0.0`), it also pushes images tagged with the tag name.
- **`docker-compose.yml`** *(optional)* - Simple compose file to run locally.

---

## Setup on GitHub & Docker Hub

1. **Create a Docker Hub account** (if you don't have one) at https://hub.docker.com.

2. **Create a repository** on Docker Hub named the same as your GitHub repo (recommended but not required).

3. **Create a Docker access token**:
   - Sign in to Docker Hub → Account Settings → Security → New Access Token.
   - Save the token securely (this will be used as `DOCKERHUB_TOKEN`).

4. **Create GitHub repo** and push the project files.

5. **Add GitHub repository secrets**:
   - In GitHub, go to your repo → Settings → Secrets and variables → Actions → New repository secret.
   - Add:
     - `DOCKERHUB_USERNAME` — your Docker Hub username
     - `DOCKERHUB_TOKEN` — the access token you created

---

## How the GitHub Actions workflow runs

- On every push to `main`, GitHub Actions:
  1. Checks out code.
  2. Logs in to Docker Hub using the secrets.
  3. Builds the Docker image.
  4. Tags it as: `<DOCKERHUB_USERNAME>/<repo-name>:latest`.
  5. Pushes it to Docker Hub.

- If you push a Git tag (e.g., `git tag v1.0.0 && git push origin v1.0.0`), the workflow will also push images tagged `v1.0.0` and `release-v1.0.0`.

---

## Local testing (before pushing)

### 1) Run the Flask app locally (without Docker)
```bash
python3 -m venv .venv
source .venv/bin/activate      # on Windows: .venv\Scripts\activate
pip install Flask
python app.py
# open http://localhost:5000 and you should see: "Hello from GitHub Actions!"
Build and run the Docker image locally
# Build the image locally (replace <youruser> and <repo> as you like)
docker build -t local-flask-demo:latest .

# Run it
docker run -p 5000:5000 local-flask-demo:latest

# open http://localhost:5000

3) Use Docker Compose (optional)
docker compose up --build
# open http://localhost:5000