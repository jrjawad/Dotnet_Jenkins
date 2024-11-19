pipeline {
    agent any

    environment {
        DOTNET_PROJECT = 'DotNet_Jenkins/DotNet_Jenkins.csproj'
        PUBLISH_DIR = 'publish'
        DOCKER_IMAGE = 'dotnet_app_auto'
        CONTAINER_NAME = 'dotnet_app_auto_web'
        DOCKER_PORT = '8002:80'
        APP_DIR = '/home/ubuntu/app'
        DOCKERFILE = 'Dockerfile'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    // Checkout the code from GitHub repository
                    git branch: 'main', url: 'https://github.com/jrjawad/Dotnet_Jenkins.git'
                }
            }
        }

        stage('Restore & Build') {
            steps {
                script {
                    // Restore and build the .NET project
                    sh 'dotnet publish $DOTNET_PROJECT -c Release -o $WORKSPACE/$PUBLISH_DIR'
                }
            }
        }

        stage('Copy Files') {
            steps {
                script {
                    // Copy required files to the application directory
                    sh """
                    cp -r $WORKSPACE/$PUBLISH_DIR/DotNet_Jenkins $WORKSPACE/$PUBLISH_DIR/DotNet_Jenkins.deps.json $WORKSPACE/$PUBLISH_DIR/DotNet_Jenkins.dll $WORKSPACE/$PUBLISH_DIR/DotNet_Jenkins.pdb $WORKSPACE/$PUBLISH_DIR/DotNet_Jenkins.runtimeconfig.json $WORKSPACE/$PUBLISH_DIR/appsettings.Development.json $WORKSPACE/$PUBLISH_DIR/appsettings.json $WORKSPACE/$PUBLISH_DIR/web.config $WORKSPACE/$PUBLISH_DIR/wwwroot $APP_DIR
                    """
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the Dockerfile
                    sh 'sudo mkdir -p $WORKSPACE/Docker_img'
                    sh 'docker build -t $DOCKER_IMAGE -f $WORKSPACE/$DOCKERFILE .'
                }
            }
        }

        stage('Remove Existing Container') {
            steps {
                script {
                    // Remove existing Docker container if any
                    def existingContainer = sh(script: "docker ps -aq -f name=$CONTAINER_NAME", returnStdout: true).trim()
                    if (existingContainer) {
                        echo "Removing existing container '$CONTAINER_NAME'..."
                        sh "docker rm -f $CONTAINER_NAME"
                    }
                }
            }
        }

        stage('Run Docker Container') {
            steps {
                script {
                    // Run the Docker container
                    sh "docker run -d --name $CONTAINER_NAME -p $DOCKER_PORT -v $APP_DIR:/app $DOCKER_IMAGE"
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment was successful!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
