#!groovy
//  groovy Jenkinsfile
properties([disableConcurrentBuilds()])

pipeline  {
    
    agent { 
        label 'master'
        }
    options {
        buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '10'))
        timestamps()
    }
    stages {
        stage("Removing old dockers") {
            steps {
                echo 'Removing docers ...'
                 dir('.'){
                    sh 'docker ps -q --filter "name=bartumeys/dashboard_frontend" | grep -q . && docker stop dashboard_frontend || echo Not stop'
                    sh 'docker ps -q --filter "name=bartumeys/dashboard_frontend" | grep -q . && docker rm dashboard_frontend -f || echo Not remove docker'

                }
            }
        }
        stage("Removing old images") {
            steps {
                echo 'Removing images ...'
                 dir('.'){
                    sh 'docker ps -q --filter "name=bartumeys/dashboard_frontend" | grep -q . && docker rmi bartumeys/dashboard_frontend || echo Not Found'
                }
            }
        }
        stage("Creating images") {
            steps {
                echo 'Creating docker image ...'
                    dir('.'){
                    sh 'docker ps -q --filter "name=bartumeys/dashboard_frontend" | grep -q . && docker build -t bartumeys/dashboard_frontend . || echo Docker imager not created'
                }
            }
        }
        stage("docker login") {
            steps {
                echo " ============== docker login =================="
                withCredentials([usernamePassword(credentialsId: 'DockerHub', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                    sh '''
                    docker login -u $USERNAME -p $PASSWORD
                    '''
                }
            }
        }
        stage("docker push image") {
            steps {
                echo " ============== pushing image =================="
                sh '''
                docker push bartumeys/dashboard_frontend:latest
                '''
            }
        }
        
        stage("docker run") {
            steps {
                echo " ============== starting frontend =================="
                sh '''
                docker run -d --restart=always --name dashboard_frontend -p 80:3000 bartumeys/dashboard_frontend:latest
                '''
            }
        }
    }
}

