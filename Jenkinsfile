pipeline {
  environment {
    dockerimagename = "dxcuong206/test"
    dockerImage = ""
  }
  agent any
  stages {
    stage('Checkout Source') {
      steps {
        git branch: 'main', credentialsId: 'GitHubCredential', url: 'https://github.com/Cuongdx77/Project_website.git'
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
          registryCredential = 'DockerHubCred'
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
        script {
          kubeconfig(credentialsId: 'mykubeconfig', serverUrl: 'https://10.26.2.123:6443') {
              sh "kubectl create -f deployment.yaml"
          }
        }     
      }
    }
  }
}

