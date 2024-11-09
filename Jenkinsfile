pipeline {
    agent any
    tools {
        maven 'maven-3.9.9'
    }
    stages{
        stage('build jar..'){
            steps{
                script{
                    echo 'building jar file'
                    sh 'mvn clean package'
                }
            }
        }
        stage('build image...'){
            steps{
                script{
                    echo "Building image..."
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh 'docker build -t azirool/demo-app:1.0.test .'
                        sh "echo '${PASS}' | docker login -u '${USER}' --password-stdin"
                        sh 'docker push azirool/demo-app:1.0.test'
                    }
                }
            }
        }
        stage('deploy...'){
            steps{
                script{
                    echo ("This is for later")
                }
            }
        }
    }
}