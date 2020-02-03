node("linux"){
  stage("Get Repo from brach") {
    checkout scm
  }
  
  stage("Create Docker Image") {
    //Dockerfile
    app = docker.build("peterkr/opsschool-project")
  }

  stage("verify Docker Image") 
  {
    sh "docker images"
  }

  stage("Push to DockerHub") {
    withDockerRegistry(credentialsId: 'dockerhub.peterkr', url: '') 
    {
      app.push()
    }
  }
