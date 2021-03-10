pipeline {
    agent any

    stages {
        stage("Checkout") {
            steps {
                script {

                }
            }
        }

        stage("Lint dockerfile") {
            steps {
                script {
                    sh "docker run --rm -i hadolint/hadolint < Dockerfile"
                }
            }
        }

        stage("Build") {
            steps {
                script {
                    docker.build("demo")
                }
            }
        }

        // can run tests here if required

        stage ("Push") {
            steps {
                script {
                    docker.withRegistry('https://250288179072.dkr.ecr.ap-south-1.amazonaws.com', 'ecr:ap-south-1:jenkins-role') {
                        docker.image('demo').push("${COMMIT_ID}")
                    } 
                }
            }
        }
    }
}
