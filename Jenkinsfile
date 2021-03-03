pipeline {
    agent any

    stages {
        stage("Checkout") {
            steps {
                script {
                    echo "========executing Checkout========"
                    git "https://github.com/bhanukai/nodejs-docker-helloworld"
                    env.BRANCH_NAME = sh(returnStdout: true, script: 'git name-rev --name-only HEAD').trim()
                    if (env.BRANCH_NAME == 'develop') {
                        env.COMMIT_ID = sh(returnStdout: true, script: 'git log -1 --format=%h').trim()
                    } else if (env.BRANCH_NAME == 'master') {
                        env.COMMIT_ID = sh(returnStdout: true, script: 'jq -r .version package.json').trim()
                    }
                    sh "echo ${COMMIT_ID}"
                    sh "aws sts get-caller-identity"
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
