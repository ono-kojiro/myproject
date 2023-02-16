pipeline {
    agent any

    stages {
        stage('configure'){
            steps {
                script {
                    if(isUnix()) {
                        sh   'sh   build.sh  configure'
                    } else {
                        bat  'call build.bat configure'
                    }
                }
            }
        }
        stage('build'){
            steps {
                script {
                    if(isUnix()) {
                        sh   'sh   build.sh  build'
                    } else {
                        bat  'call build.bat build'
                    }
                }
            }
        }
        stage('test'){
            steps {
                script {
                    if(isUnix()) {
                        sh   'sh   build.sh test'
                    } else {
                        bat  'call build.bat test'
                    }
                }
            }
        }
        stage('install'){
            steps {
                script {
                    if(isUnix()) {
                        sh   'sh   build.sh install'
                    } else {
                        bat  'call build.bat install'
                    }
                }
            }
        }
        stage('package'){
            steps {
                script {
                    if(isUnix()) {
                        sh   'sh   build.sh package'
                    } else {
                        bat  'call build.bat package'
                    }
                }
            }
        }
        stage('upload'){
            steps {
                script {
                    if(isUnix()) {
                        sh   'sh   build.sh upload'
                    } else {
                        bat  'call build.bat upload'
                    }
                }
            }
        }
        stage('publish'){
            steps {
                script {
                    if(isUnix()) {
                        sh   'sh   build.sh  publish'
                    } else {
                        bat  'call build.bat publish'
                    }
                }
            }
        }
    }
}
