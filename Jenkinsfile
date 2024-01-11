node {
  stage('Git Hub Checkout') {
    git branch: 'main', credentialsId: 'GitHubCredential', url: 'https://github.com/Cuongdx77/Project_website.git'
  }
  
  stage('Build Docker Image') {
    sh 'docker build -t dxcuong206/test:04 .'
  }
  
  stage('Push Docker Image Into Docker Hub') {
    withCredentials([string(credentialsId: 'Docker_Password', variable: 'Docker_PassWord')]) {
      sh "docker login -u dxcuong206 -p ${Docker_Password}"
    }
    sh 'docker push dxcuong206/test:04'
  }
  
  stage('Deploy to K8S') {
    kubeconfig(credentialsId: 'mykubeconfig', serverUrl: 'https://10.26.2.123:6443')  {    
    sh 'kubectl apply -f deployment.yaml'
    }
  }
}
