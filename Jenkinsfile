pipeline {
  agent {
    kubernetes {
      label 'buildah-pod' // Указываем метку вашего существующего пода
    }
  }
  stages {
    stage('Build with Buildah') {
      steps {
        container('buildah') {
          sh 'buildah build -t darinpope/jenkins-example-buildah:8.5-230 .'
        }
      }
    }
  }
}
