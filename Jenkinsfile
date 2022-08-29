pipeline {
    agent any

    stages {
        stage('Setup Mutliarch') {
            steps {
                sh 'docker run --privileged --rm tonistiigi/binfmt --install all'
            }
        }
        
        stage('Build') {
            steps {
                script {
                    env.tags = params.additional ? ((params.additional.split(",").collect {"-t bdew1/jenkins-docker:"+it}).join(" ")) : ""

                    docker.withRegistry('', 'docker_hub_bdew1') {
                        sh 'docker context create builder'
                        sh 'docker buildx create --name multibuilder --use --driver docker-container builder'
                        sh 'docker buildx build --platform=linux/arm64,linux/amd64 --build-arg TAG=${tag} -t bdew1/jenkins-docker:${tag} ${tags} --push .'
                    }
                }                
            }
        }
    }
}
