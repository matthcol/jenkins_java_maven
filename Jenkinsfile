pipeline {
    agent any

    parameters {
        string(name: 'URL', description: 'URL Java Project to Build')
        string(name: 'BRANCH', defaultValue: 'main', description: 'Branch to Build')
        choice(name: 'JAVA_VERSION', choices: ['11', '17'], description: 'Java Version')
    }

    tools {
        // Install the Maven version configured as "M3" and add it to the path.
        maven "M3"
        jdk "JDK${params.JAVA_VERSION}"
    }

    stages {
        stage('Fetch') {
            steps {
                // Get some code from a GitHub repository
                git url: "${params.URL}",
                    branch: "${params.BRANCH}"
                sh "../change_java_version.sh ${params.JAVA_VERSION}"
            }
        }
        stage('Compile') {
            steps {
                sh "mvn clean compile"
            }
        }
        stage('Test') {
            steps {
                sh "mvn test"
            }
            post {
                always {
                    junit '**/target/surefire-reports/TEST-*.xml'
                }
            }
        }
        stage('Package') {
            steps {
                sh "mvn -DskipTests -Dmaven.test.skip package"
            }
            post {
                success {
                    archiveArtifacts 'target/*.jar,target/*.war'
                }
            }
        }
    }
}
