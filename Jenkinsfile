pipeline {
    agent any

    tools {
        maven 'Maven-3.9'
        jdk 'JDK-17'
    }

    stages {
        stage('Checkout') {
            steps {
                git url: 'https://github.com/SanthiyaDeviMuthaiah/online-shop-qa.git', branch: 'main'
            }
        }

        stage('Run Tests') {
            steps {
                bat 'mvn clean test'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'reports/**', allowEmptyArchive: true
        }
    }
}