pipeline {
    agent any

    environment {
        registry = "renfe1972/devops-a1"
        tag = "1.0"
        registryCredentials = "renfe1972"          // Credencial DockerHub
        repository = "https://github.com/josemariacortes/devops-a1.git"
        repositoryCredentials = "jenkins-token"  // Credencial GitHub
        project = "devops-a3"
    }

    stages {

        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }

        stage('Checkout Code') {
            steps {
                git branch: 'main',
                    credentialsId: repositoryCredentials,
                    url: repository
            }
        }

        stage('Build Image') {
            steps {
                script {
                    dockerImage = docker.build("${registry}:${tag}")
                }
            }
        }

        stage('Test Container') {
            steps {
                script {
                    try {
                        sh "docker run --name $project ${registry}:${tag}"
                    } finally {
                        sh "docker rm $project"
                    }
                }
            }
        }

        stage('Push to DockerHub') {
            steps {
                script {
                    docker.withRegistry('', registryCredentials) {
                        dockerImage.push()
                    }
                }
            }
        }

        stage('Clean Local Image') {
            steps {
                sh "docker rmi ${registry}:${tag}"
            }
        }
    }

    post {
        failure {
            echo "El pipeline ha fallado."
        }
    }
}
