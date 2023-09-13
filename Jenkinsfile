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
        script {
          // Используем плагин Docker для сборки образа
          def dockerImage = docker.build("igorvit/diploma:1.0.2")
        }
      }
    }
    stage('Login') {
      steps {
        script {
          // Используем плагин Docker для входа в Docker Hub
          docker.withRegistry('', DOCKERHUB_CREDENTIALS) {
            // Нет необходимости выполнять docker login - плагин автоматически управляет аутентификацией
          }
        }
      }
    }
    stage('Push') {
      steps {
        script {
          // Используем плагин Docker для публикации образа
          def dockerImage = docker.image("igorvit/diploma:1.0.2")
          dockerImage.push()
        }
      }
    }
  }
  post {
    always {
      script {
        // Используем плагин Docker для выхода из Docker Hub
        docker.withRegistry('', DOCKERHUB_CREDENTIALS) {
          // Нет необходимости выполнять docker logout - плагин автоматически управляет выходом
        }
      }
    }
  }
}
