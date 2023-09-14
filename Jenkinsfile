pipeline {
  agent {
    kubernetes {
      yaml '''
apiVersion: v1
kind: Pod
metadata:
  name: buildah
spec:
  containers:
  - name: buildah
    image: quay.io/buildah/stable:v1.23.1
    command:
    - cat
    tty: true
    securityContext:
      privileged: true
'''   
    }
  }
  options {
    buildDiscarder(logRotator(numToKeepStr: '2'))
    durabilityHint('PERFORMANCE_OPTIMIZED')
    disableConcurrentBuilds()
  }
  environment {
    DH_CREDS=credentials('docker-cred-id')
    GIT_REPO = 'https://github.com/IgorVityukhovsky/diploma-docker'
    TAG_VERSION = sh (
            script: "git ls-remote --tags $GIT_REPO | grep -o 'refs/tags/[^/]*\$' | sort -V | tail -n 1 | cut -d '/' -f 3",
            returnStdout: true).trim()
    TAG = "${TAG_VERSION}.${BUILD_NUMBER}"
  }
  stages {
    stage('Build with Buildah') {
      steps {
        container('buildah') {
          sh "echo ${TAG_VERSION}"
          sh "echo ${BUILD_NUMBER}"
          sh "buildah build -t igorvit/dimploma:${TAG} ."
        }
      }
    }
    stage('Login to Docker Hub') {
      steps {
        container('buildah') {
          sh "echo $DH_CREDS_PSW | buildah login -u $DH_CREDS_USR --password-stdin docker.io"
        }
      }
    }
    stage('Tag Image') {
      steps {
        container('buildah') {
          sh "buildah tag igorvit/dimploma:${TAG} igorvit/dimploma:latest"
        }
      }
    }
    stage('Push Image') {
      steps {
        container('buildah') {
          sh "buildah push igorvit/dimploma:${TAG}"
        }
      }
    }
    stage('Deploy') {
      agent any
      steps {
          sh "kubectl apply -f https://github.com/IgorVityukhovsky/diploma-docker/blob/main/my-app-deploy-update.yml"
        }
    }
  }
  post {
    always {
      container('buildah') {
        sh 'buildah logout docker.io'
      }
    }
  }
}

