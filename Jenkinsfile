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
        stage('install'){
            steps {
                bat  'call build.bat install'
            }
        }
        stage('package'){
            steps {
                bat  'call build.bat package'
            }
        }
        stage('upload'){
            steps {
                bat  'call build.bat upload'
            }
        }
        stage('publish'){
            steps {
                bat  'call build.bat publish'
            }
        }
    }
}
