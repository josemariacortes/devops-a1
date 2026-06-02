pipeline {
    agent any

    tools {
        SonarRunnerInstallation 'sonar-scanner'
    }
    
    environment {
        registry = "renfe1972/devops-a1"
        tag = "1.0"
        registryCredentials = "dockerhub"
        repository = "https://github.com/josemariacortes/devops-a1.git"
        repositoryCredentials = "jenkins-token"
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

        stage('Static Analysis - SonarQube') {
            environment {
                SONAR_TOKEN = credentials('SONAR_TOKEN')
            }
            steps {
                withSonarQubeEnv('sonarqube') {
                    sh '''
                        sonar-scanner \
                        -Dsonar.projectKey=devops-a3 \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://localhost:9000 \
                        -Dsonar.login=$SONAR_TOKEN
                    '''
                }
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
