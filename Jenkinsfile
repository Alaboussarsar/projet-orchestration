pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'terraform init -input=false'
            }
        }

        stage('Validate') {
            steps {
                sh 'terraform fmt -check -recursive'
                sh 'terraform validate'
            }
        }

        stage('Plan') {
            steps {
                sh 'terraform plan -out=tfplan -input=false'
            }
        }

        stage('Approve') {
            steps {
                input message: "Appliquer le plan sur ECS + Kubernetes ?"
            }
        }

        stage('Apply') {
            steps {
                sh 'terraform apply -input=false tfplan'
            }
        }
    }

    post {
        success {
            echo 'Déploiement ECS + Kubernetes réussi.'
        }
        failure {
            echo 'Échec du pipeline — voir les logs ci-dessus.'
        }
    }
}
