pipeline {
  agent {
    kubernetes { 
    }
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '3'))
    durabilityHint('PERFORMANCE_OPTIMIZED')
    disableConcurrentBuilds()
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
