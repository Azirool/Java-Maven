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
                    sh 'mvn build-helper:parse-version version-set \
                        -DnewVersion=\\\${parsedVersion.majorVersion}.\\\${parsedVersion.minorVersion}.\\\${parsedVersion.nextIncrementalVersion} \
                        version:commit'
                    def findVersion = readFIle('pom.xml') =~ '<version>(.+)</version>'
                    def currentVersion = findVersion[0][1]
                    env.IMAGE_NAME = "$currentVersion-$BUILD_NUMBER"
                }
            }
        }
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
                        sh "docker build -t azirool/demo-app:'${IMAGE_NAME}' ."
                        sh "echo '${PASS}' | docker login -u '${USER}' --password-stdin"
                        sh "docker push azirool/demo-app:1.0.'${IMAGE_NAME}'"
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