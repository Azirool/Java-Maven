# Java Maven App - Integration with Docker, Jenkins, and GitHub Webhooks

This is a simple Java Spring Boot project created to practice integrating Jenkins, Docker, and GitHub webhooks. 
The purpose of this project is to gain hands-on experience with automated CI/CD processes, including versioning, 
building, and deploying using a Jenkins multibranch pipeline triggered by GitHub webhooks.

## Overview Process
Versioning > Build JAR > Build Docker Image > Push to DockerHub > Deploy to server > Commit to GitHub repo

## CI/CD Process with Jenkins

This project is designed to be used in a CI/CD pipeline, specifically with the following setup:
1. **GitHub Webhooks**: Webhooks are configured to trigger Jenkins automatically on each new push to the repository.
2. **Jenkins Multibranch Pipeline**: Jenkins will detect branches and pull requests in the repository and automatically 
build them according to the pipeline script (`Jenkinsfile`).
3. **Versioning**: Before each build, the Jenkins pipeline script will increment the project version as specified in 
the `pom.xml` file.
4. **Docker Integration**: Jenkins builds a Docker image and pushes it to Docker Hub for easy deployment.
