pipeline {
  agent any

	environment {
		DOCKERHUB_CREDENTIALS=credentials('jenkins-dev-key-dockerhub')
	}

  stages {

    stage('Fetch code') {
      steps {
        git branch: 'develop', credentialsId: 'jenkins-dev-key', url: 'https://github.com/doomokun/demo-api.git'
      }
    }

    stage('Build') {
      steps {
        sh 'docker build -t tommydevv1/demo-api:latest .'
      }
    }

		stage('Login') {
			steps {
				sh 'echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin'
			}
		}

		stage('Push') {
			steps {
				sh 'docker push tommydevv1/demo-api:latest'
			}
		}

  }

	post {
		always {
			sh 'docker logout'
		}
	}
}