pipeline {
    agent any

    stages {
        stage('build') {
            steps {
                sh '''
                    echo "--Running build--"
                    echo "--with npm install--"
                    DOCKER_BUILDKIT=1 docker build -f Dockerfile_for_pipeline -t baraktzoref/final_project_be --target bld .
                '''
            }
        }
        stage('delivery') {
            steps {
                sh '''
                    echo "--Running DLV--"                    
                    DOCKER_BUILDKIT=1 docker build -f Dockerfile_for_pipeline -t baraktzoref/final_project_be --target delivery .
                '''
            }
        }
        stage('run') {
            steps {
                sh '''
                    echo "--Activate docker container--"
                    docker run -d baraktzoref/final_project_be
                '''
            }
        }
        stage('push-image-to-repo') {
            steps {
                sh (script:"set +x && docker login -u ${username} -p ${pass} && set -x")
                sh '''
                    echo "--Push docker image--"
                    docker tag baraktzoref/final_project_be baraktzoref/final_project_be:jenkins-${BUILD_NUMBER}
                    
                    docker push baraktzoref/final_project_be --all-tags
                    
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
