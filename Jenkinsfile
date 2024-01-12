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
    agent{
        kubernetes {
            cloud 'Kubernetes'
            yamlFile 'jenkins/Pod.yaml'
        }
    }
    stage('Deploying container to Kubernetes') {
      steps {
        script {
          kubernetesDeploy(configs: "deployment.yaml")
        }
      }
    }
  }
}
