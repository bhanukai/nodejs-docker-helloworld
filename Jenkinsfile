pipeline {
    agent any

    stages {
        stage("Checkout") {
            steps {
                script {
                    sh "git rev-parse --abbrev-ref HEAD"
                    env.LATEST_TAG = sh(returnStdout: true, script: 'git describe --tag').trim()
                    sh "git checkout ${LATEST_TAG}"
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
                        docker.image('demo').push("${LATEST_TAG}")
                    } 
                }
            }
        }
    }
}
