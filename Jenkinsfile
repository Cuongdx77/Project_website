pipeline {
  environment {
    dockerimagename = "dxcuong206/test"
    dockerImage = ""
  }
  agent{
      kubernetes {
          cloud 'Kubernetes'
          yamlFile 'pod.yaml'
      }
    }
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
      steps {
        script {
          withKubeConfig([credentialsId: 'mykubeconfig']) {                    
                    sh "kubectl create -f deployment.yaml}" 
          }
        }     
      }
    }
  }
}

