pipeline {
    agent any

    environment {
        OLD_VERSION = '1'
        NEW_VERSION = '2'
        DOCKER_IMAGE_NAME = "igorvit/diploma:${NEW_VERSION}"
        DOCKER_CRED_ID = 'docker-cred-id'
    }

    stages {
        stage('Build and Push Docker Image') {
            steps {
                script {
                    // Сборка Docker-образа
                    docker.build(DOCKER_IMAGE_NAME, "-f Dockerfile .")

                    // Логин в Docker Hub с использованием учетных данных
                    docker.withRegistry('https://registry.hub.docker.com', DOCKER_CRED_ID) {
                        // Пуш Docker-образа в Docker Hub
                        docker.image(DOCKER_IMAGE_NAME).push()
                    }
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline выполнен успешно"
        }
        failure {
            echo "Pipeline завершился с ошибкой"
        }
    }
}
