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

        // stage('Composer Install') {
        //     steps {
        //         sh '''
        //             curl -sS https://getcomposer.org/installer | php
        //             php composer.phar install --no-interaction --prefer-dist
        //         '''
        //     }
        // }

        stage('Prepare Laravel') {
            steps {
                sh '''
                    cp .env.example .env || true
                    php artisan key:generate || true
                    chmod -R 775 storage bootstrap/cache || true
                '''
            }
        }

        stage('Start Docker (NGINX + PHP-FPM)') {
            steps {
                sh 'docker compose down || true'
                sh 'docker compose up -d --build'
            }
        }
    }

    post {
        always {
            echo 'Laravel deployed using Docker.'
        }
    }
}
