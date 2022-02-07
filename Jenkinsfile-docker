pipeline {
    agent {
        docker {
            image 'maven:3.8.1-adoptopenjdk-11'
            args '-v /root/.m2:/root/.m2'
        }
    }
    options {
        skipStagesAfterUnstable()
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn -B -DskipTests clean package'
            }
        }
        stage('Test') {
            steps {
                sh 'mvn test'
            }
            post {
                always {
                    junit 'target/*.xml'
                    archive 'target/*.jar'
                }
            }
        }
        stage('Deliver') {
            steps {
                sh './deliver.sh'
            }
        }
    }

    stage('Build Docker Image') {
      // build docker image
      sh "whoami"
      sh "ls -all /var/run/docker.sock"
      sh "mv ./target/hello*.jar ./data"

      dockerImage = docker.build("hello-world-java")
    }

    stage('Deploy Docker Image'){

      // deploy docker image to nexus

      echo "Docker Image Tag Name: ${dockerImageTag}"

      sh "docker login -u admin -p admin123 ${dockerRepoUrl}"
      sh "docker tag ${dockerImageName} ${dockerImageTag}"
      sh "docker push ${dockerImageTag}"
    }
}
