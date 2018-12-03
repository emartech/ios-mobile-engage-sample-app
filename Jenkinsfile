@Library('general-pipeline') _

def clone(udid) {
    checkout changelog: true, poll: true, scm: [$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [[$class: 'RelativeTargetDirectory', relativeTargetDir: "$udid/ios-mobile-engage-sample-app"]], submoduleCfg: [], userRemoteConfigs: [[url: 'git@github.com:emartech/ios-mobile-engage-sample-app.git']]]
}

def podi(udid) {
  lock("pod") {
    sh "cd $udid/ios-mobile-engage-sample-app && pod repo update && pod update"
  }
}

def uninstallSample(ecid) {
    sh "${env.CFG_UTIL}cfgutil --ecid $ecid remove-app com.emarsys.mobile-engage-sample-app || true"
}

def buildAndTest(platform, udid) {
  lock(udid) {
    def uuid = UUID.randomUUID().toString()
    try {
        sh "mkdir /tmp/$uuid"
        retry(3) {
            sh "cd $udid/ios-mobile-engage-sample-app && fastlane scan --scheme mobile-engage-sample-app-iosUITests -d 'platform=$platform,id=$udid' --derived_data_path $uuid -o test_output/unit/"
        }
    } catch(e) {
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
      junit "$udid/ios-mobile-engage-sample-app/test_output/unit/*.junit"
      archiveArtifacts "$udid/ios-mobile-engage-sample-app/test_output/unit/*"
    }
  }
}

node('master') {
  withSlack channel:'jenkins', {
      stage('Start'){
          deleteDir()
      }
      stage('Remove previous') {
        parallel iPhone_5S: {
            uninstallSample env.IPHONE_5S_ECID
         }, iPhone_6S: {
             uninstallSample env.IPHONE_6S_ECID
        }, iPad_Pro: {
            uninstallSample env.IPAD_PRO_ECID
        }, iOS_9_3_Simulator: {
            sh "xcrun simctl uninstall booted com.emarsys.mobile-engage-sample-app || true"
        }, failFast: false
      }
      stage('Git Clone') {
        parallel iPhone_5S: {
            clone env.IPHONE_5S
         }, iPhone_6S: {
             clone env.IPHONE_6S
        }, iPad_Pro: {
            clone env.IPAD_PRO
        }, iOS_9_3_Simulator: {
            clone env.IOS93SIMULATOR
        }, failFast: false
      }
      stage('Pod install') {
        parallel iPhone_5S: {
            podi env.IPHONE_5S
         }, iPhone_6S: {
             podi env.IPHONE_6S
        }, iPad_Pro: {
            podi env.IPAD_PRO
        }, iOS_9_3_Simulator: {
            podi env.IOS93SIMULATOR
        }, failFast: false
      }
      stage('Build and Test'){
            parallel iPhone_5S: {
                buildAndTest 'iOS', env.IPHONE_5S
             }, iPhone_6S: {
                 buildAndTest 'iOS', env.IPHONE_6S
            }, iPad_Pro: {
                buildAndTest 'iOS', env.IPAD_PRO
            }, iOS_9_3_Simulator: {
                buildAndTest 'iOS Simulator', env.IOS93SIMULATOR
        }, failFast: false
      }
      stage('Create Enterprise Distribution Package') {
        sh "mkdir artifacts"
        def udid = env.IPAD_PRO
        sh "cd $udid/ios-mobile-engage-sample-app && gym --scheme mobile-engage-sample-app-ios --export_method enterprise -o ../../artifacts/ --verbose"
        archiveArtifacts "artifacts/*"
      }


      stage('Deploy IPA to Amazon S3') {
          sh env.IOS_AWS_DEPLOY_COMMAND
      }

      stage('Finish') {
        echo "That is just pure awesome!"
      }
  }
}
