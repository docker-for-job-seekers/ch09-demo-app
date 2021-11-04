pipeline {
    environment {
        registry = "dockerforjobseekers/web"
        DOCKER_PWD = credentials('docker-login-pwd')
    }
    agent {
        docker {
            image 'dockerforjobseekers/node-docker'
            args '-p 3000:3000'
            args '-w /app'
            args '-v /var/run/docker.sock:/var/run/docker.sock'
        }
    }
    options {
        skipStagesAfterUnstable()
    } 
    stages {
        stage('Build') {
            steps {
                echo('Building...')
                sh 'cd web && npm install'
            }
        }
        stage('Test') {
            steps {
                echo 'Testing...'
                sh 'cd web && npm test'
            } 
        }
        stage('Build & push Docker image') {
            steps {
                echo 'Building & pushing Docker image...'
                sh 'docker image build -t $registry:$BUILD_NUMBER web'
                sh 'docker login -u gnschenker -p $DOCKER_PWD'
                sh 'docker image push $registry:$BUILD_NUMBER'
                sh 'docker image rm $registry:$BUILD_NUMBER'
            }
        }
        stage('Deploy and smoke test') { 
            steps { 
                sh './jenkins/scripts/deploy.sh' 
                sh './jenkins/scripts/smoke-test.sh' 
            } 
        } 
        stage('Cleanup') { 
            steps { 
                sh './jenkins/scripts/cleanup.sh' 
            } 
        }
    }
}