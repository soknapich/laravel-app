pipeline {
    agent any

    environment {
        COMPOSER_HOME = "${WORKSPACE}/.composer"
    }

    stages {
        // stage('Clone Laravel Repo') {
        //     steps {
        //         git credentialsId: 'your-credentials-id',
        //             url: 'https://bitbucket.org/your-username/your-laravel-repo.git',
        //             branch: 'main'
        //     }
        // }

        stage('PHP Install') {
            steps {
                sh '''
                    docker run -d \
                    --name laravel-php \
                    -v $(pwd):/var/www/html \
                    php:8.2-fpm
                '''
            }
        }

        
        stage('NGINX Install') {
            steps {
                sh '''cat $(pwd)/nginx.conf '''
                sh '''
                 
                 docker run -d \
                    --name laravel-nginx \
                    --link laravel-php:laravel-php \
                    -p 8085:80 \
                    -v $(pwd):/var/www/html:ro \
                    -v $(pwd)/nginx.conf:/etc/nginx/nginx.conf \
                    nginx:alpine
                '''
            }
        }
        
        // -v $(pwd)/docker/nginx.conf:/etc/nginx/nginx.conf:ro \
        // stage('Prepare Laravel') {
        
        //     steps {
        //         sh '''
        //             cp .env.example .env || true
        //             php artisan key:generate || true
        //             chmod -R 775 storage bootstrap/cache || true
        //         '''
        //     }
        // }

        // stage('Start Docker (NGINX + PHP-FPM)') {
        //     steps {
        //         sh 'docker compose down || true'
        //         sh 'docker compose up -d --build'
        //     }
        // }
    }

    post {
        always {
            echo 'Laravel deployed using Docker.'
        }
    }
}
