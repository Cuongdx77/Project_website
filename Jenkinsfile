pipeline {
  environment {
    dockerimagename = "dxcuong206/test"
    dockerImage = ""
  }
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git branch: 'main', credentialsId: 'GitHubCred', url: 'https://github.com/Cuongdx77/Project_website.git'
      }
    }
    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }
    stage('Pushing Image') {
      environment {
          registryCredential = 'DockerCred'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
          }
        }
      }
    }
    stage('Deploying container to Kubernetes') {
      agent {
        kubernetes {
          cloud 'Kubernetes'
          yamlFile 'pod.yaml'
        }
      }
      steps {
            container('jnlp') {
              sh 'kubectl create -f deployment.yaml'
          }     
      }
    }
  }
}

