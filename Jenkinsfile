pipeline {
    agent any

    stages {
        stage('build') {
            steps {
                sh '''
                    echo "-----Running build stage npm install-----"
                    DOCKER_BUILDKIT=1 docker build -f Dockerfile_for_pipeline -t elad6456/final_challenge_be_app --target builder .
                '''
            }
        }
        stage('delivery') {
            steps {
                sh '''
                    echo "-----Running delivery stage-----"
                    DOCKER_BUILDKIT=1 docker build -f Dockerfile_for_pipeline -t elad6456/final_challenge_be_app --target delivery .
                '''
            }
        }
        stage('run') {
            steps {
                sh '''
                    echo "-----Running the docker container-----"
                    docker run -d elad6456/final_challenge_be_app
                '''
            }
        }
        stage('push-image-to-repo') {
            steps {
                sh (script:"set +x && docker login -u ${username} -p ${pass} && set -x")
                sh '''
                    echo "-----Pushing docker image to repo-----"
                    docker tag elad6456/final_challenge_be_app elad6456/final_challenge_be_app:jenkins-${BUILD_NUMBER}
                    
                    docker push elad6456/final_challenge_be_app --all-tags
                    
                '''
            }
        }
        stage('cleanup') {
            steps {
                sh '''
                    echo "-----Running docker prune-----"
                    docker system prune -f
                '''
            }
        }
    }
}
