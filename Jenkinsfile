pipeline {
  agent none

  options {
    timestamps()
    buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '', numToKeepStr: '15')
    skipStagesAfterUnstable()
    timeout(5)
  }

  stages {

    stage('Build') {
      agent {
        docker {
          image 'epitechcontent/epitest-docker'
        }
      }
      steps {
        timeout(time: 10) {
          sh 'make fclean'
          sh 'make'
        }
      }
    }

    stage('Tests') {
      agent {
        docker {
          image 'epitechcontent/epitest-docker'
        }
      }
      steps {
        retry(count: 3) {
          timeout(time: 20) {
            sh 'make tests_run_coverage'
          }
        }
      }
    }

    stage('Deploy') {
      agent any
      when {
        anyOf {
          branch 'master'
          branch 'dev'
        }
        allOf {
          not {
            changeRequest()
          }
          not {
            triggeredBy('TimerTrigger')
          }
        }
      }
      steps {
        sshagent (credentials: ['epitech-global']) {
          sh "git push git@git.epitech.eu:/florent.poinsard@epitech.eu/FUN_imageCompressor_2018 --force ${env.BRANCH_NAME}:${env.BRANCH_NAME}"
        }
      }
    }
  }
  post {
    success {
      slackSend (color: '#48f100', message: "FUNC -> SUCCESS ${env.BRANCH_NAME} ${env.BUILD_DISPLAY_NAME}")
    }
    failure {
      slackSend (color: '#ff2900', message: "FUNC -> FAILED ${env.BRANCH_NAME} ${env.BUILD_DISPLAY_NAME}")
    }
  }
}