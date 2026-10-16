pipeline{
    agent any
    environment {
        DOCKERHUB = credentials('DOCKERHUB_creds')
    }

    stages {
        stage('Docker Login') {
            steps {
                bat 'terraform --version'
                bat 'echo %DOCKERHUB_PSW%| docker login -u %DOCKERHUB_USR% --password-stdin'
            }
        }
        
        stage("Docker Image build") {
            steps{
                bat 'docker build -t my-webpage .'
                bat 'docker tag my-webpage mohammedarmaan2005/my-webpage'
                bat 'docker push mohammedarmaan2005/my-webpage'
            }
        }

        stage("Backend Intialization"){
            steps{
                 withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_credentials']]) {
                dir('backend'){
                    bat 'terraform -version'
                    bat 'terraform init -reconfigure'
                    bat 'terraform apply -auto-approve'
                        }
                    }
                }
            }

        stage("Terraform Initialization") {
            steps {
                withCredentials([[$class: 'AmazonWebServicesCredentialsBinding', credentialsId: 'AWS_credentials']]) {
                    bat 'terraform init -reconfigure'
                    bat 'terraform fmt'
                }
            }
        }

        stage("Terraform planning") {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'AWS_credentials']
                ]) {
                    bat 'terraform validate'
                    bat 'terraform plan -out=tfplan'
                }
            }
        }

        stage("Terraform execution") {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'AWS_credentials']
                ]) {
                    bat 'terraform apply -auto-approve tfplan'
                }
            }
        }

        stage("Terraform state check") {
            steps {
                withCredentials([
                    [$class: 'AmazonWebServicesCredentialsBinding',
                     credentialsId: 'AWS_credentials']
                ]) {
                    bat 'terraform state list'
                }
            }
        }
    }

    post {
        success {
            echo "======== UPLOADED & HOSTED SUCCESSFULLY ========"
        }
        failure {
            echo "======== EXECUTION FAILED ========"
        }
    }
}