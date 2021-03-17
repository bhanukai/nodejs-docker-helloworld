def skipRemainingTests = false

pipeline{
    agent any
    
        stages {
        stage("Checkout") {
            steps {
                script {
                    echo "========executing Checkout========"
                    git "https://github.com/bhanukai/nodejs-docker-helloworld.git"
                    sh "git checkout master"

                    env.BRANCH_NAME = sh(returnStdout: true, script: 'git branch --show-current').trim()

                    if (env.BRANCH_NAME == params.DEVELOP_BRANCH) {
                    
                        def commitMessage = sh(returnStdout: true, script: "git log -1 --format=%s").trim()
                        
                        // skip remaining steps if commit does not contain BUILD_KEYWORD
                        if (commitMessage.contains(params.BUILD_KEYWORD)) {
                            skipRemainingStages = true
                            return
                        }
                        
                        def commitID = sh(returnStdout: true, script: 'git log -1 --format=%h').trim()
                        env.TAG = "dev-${commitID}"
                    } else if (env.BRANCH_NAME == params.MASTER_BRANCH) {
                        def version = sh(returnStdout: true, script: "jq -r .version package.json").trim()
                        def commitMessage = sh(returnStdout: true, script: "git log -1 --format=%s").trim()
                        
                        if (commitMessage.contains(params.HOT_FIX_KEYWORD)) {
                            env.TAG = "master-${version}-hot"
                        } else {
                            env.TAG = "master-${version}"
                        }

                        sh "echo ${TAG}"
                    } else {
                        skipRemainingStages = true
                    }
                }
            }
        }
        }
}
