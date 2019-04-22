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
          sh 'echo ok'
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
        // sh 'mkdir coverage_build'
        retry(count: 3) {
          timeout(time: 20) {
            sh 'echo ok'
          }
        }
        // sh 'gcovr -x > coverage_build/coverage.xml'
        // cobertura coberturaReportFile: 'coverage_build/coverage.xml', conditionalCoverageTargets: '70, 0, 0', failNoReports: false, failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 5, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII'
        // junit 'report/*.xml'
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