pipeline {
    agent any
    tools {
        maven 'maven-3.9.9'
    }
    stages{
        stage('incrementing version'){
            steps{
                script{
                    echo "Incrementing jar version package"
                    sh 'mvn build-helper:parse-version versions:set \
                        -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                        versions:commit'
                    def findVersion = readFile('pom.xml') =~ '<version>(.+)</version>'
                    def currentVersion = findVersion[0][1]
                    env.IMAGE_NAME = "'${currentVersion}'-$BUILD_NUMBER"
                    echo 'Increment version: SUCCESS'
                }
            }
        }
        stage('build jar..'){
            steps{
                script{
                    echo 'building jar file'
                    sh 'mvn clean package'
                    echo 'Build JAR: SUCCESS'
                }
            }
        }
        stage('build image...'){
            steps{
                script{
                    echo 'Building image...'
                    withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'PASS', usernameVariable: 'USER')]) {
                        sh "docker build -t azirool/demo-app:'${IMAGE_NAME}' ."
                        sh "echo '${PASS}' | docker login -u '${USER}' --password-stdin"
                        sh "docker push azirool/demo-app:'${IMAGE_NAME}'"
                    }
                    echo 'Build Docker Image: SUCCESS'
                }
            }
        }
        stage('deploy...'){
            steps{
                script{
                    echo ("Nothing to deploy for now")
                }
            }
        }
        stage('commiting to github repo'){
            steps{
                script{
                    withCredentials([usernamePassword(credentialsId: 'github-token', passwordVariable: 'PASS', usernameVariable: 'USER')]){
                        sh 'git config --global user.email "aziroolfareed31@gmail.com"'
                        sh 'git config --global user.name "azirool"'

                        //sh "git remote add origin https://github.com/Azirool/Java-Maven.git"
                        sh 'git remote set-url origin https://${USER}:${PASS}@github.com/Azirool/Java-Maven.git'
                        sh 'git add .'
                        sh 'git commit -m "ci:versioning"'
                        sh 'git push origin HEAD:main'
                    }
                    echo 'Commiting to Github: SUCCESS'
                }
            }
        }
    }
}
