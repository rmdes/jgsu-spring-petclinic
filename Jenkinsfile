node {
  stage('SCM') {
    checkout scm
  }
  stage('SonarQube Analysis') {
    def mvn = tool 'Default Maven';
    withSonarQubeEnv() {
      sh 'mvn clean verify -T 4 sonar:sonar -Dsonar.projectKey=rmdes_jgsu-spring-petclinic_AX7V_pSfED3aUq9OQqmr'
    }
  }
}

