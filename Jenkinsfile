node {
  stage('Git Hub Checkout') {
    git credentialsId: 'GitHubCredential', url: 'https://github.com/Cuongdx77/Project_website.git'
  }
  
  stage('Build Docker Image') {
    sh 'docker build -t dxcuong206/test:04 .'
  }
  
  stage('Push Docker Image Into Docker Hub') {
    withCredentials([string(credentialsId: 'Docker_Password', variable: 'Docker_Password')]) {
      sh "docker login -u dxcuong206 -p ${Docker_Password}"
    }
    sh 'docker push dxcuong206/test:04'
  }
  
  stage('Deploy to K8S') {
  }
}
