pipeline {
  agent any
  options {
    buildDiscarder(logRotator(numToKeepStr: '5'))
  }
  environment {
    DOCKERHUB_CREDENTIALS = credentials('docker-cred-id')
  }
  stages {
    stage('Build') {
      steps {
        sh 'docker build -t igorvit/diploma:1.0.2 .'
      }
    }
    stage('Login') {
      steps {
        sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
      }
    }
    stage('Push') {
      steps {
        sh 'docker push igorvit/diploma:1.0.2'
      }
    }
  }
  post {
    always {
      sh 'docker logout'
    }
  }
}
