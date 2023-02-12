pipeline {
    agent { label 'windows' }

    stages {
        stage('configure'){
            steps {
                bat  'call build.bat configure'
            }
        }
        stage('build'){
            steps {
                bat  'call build.bat build'
            }
        }
        stage('test'){
            steps {
                bat  'call build.bat build'
            }
        }
    }
}
