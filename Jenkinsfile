node {

    stage ('소스체크아웃') {
        checkout([$class: 'GitSCM',
            branches: [[name: '*/master']],
            doGenerateSubmoduleConfigurations: false, extensions: [],
            submoduleCfg: [],
            userRemoteConfigs: [[credentialsId: 'DevPro', url: 'https://devpro.ktds.co.kr/msa/trace.git']]])
    }


    stage ('스크링팅'){
        sh 'ssh ec2-user@ip-172-31-12-174 "mkdir -p /home/ec2-user/trace/log"'
        sh 'scp ./start.sh ec2-user@ip-172-31-12-174:/home/ec2-user/trace'
        sh 'scp ./shutdown.sh ec2-user@ip-172-31-12-174:/home/ec2-user/trace'
        sh 'ssh ec2-user@ip-172-31-12-174 "chmod a+x /home/ec2-user/trace/*.sh"'
    }

    stage ('서버 중지'){
        sh 'ssh ec2-user@ip-172-31-12-174 "/home/ec2-user/trace/shutdown.sh || true"'
    }

    stage ('빌드') {
        sh './gradlew clean build'
    }

    stage ('배포') {
        sh 'scp build/libs/trace-1.0.0-RELEASE.jar ec2-user@ip-172-31-12-174:/home/ec2-user/trace'
    }

    stage ('서버 시작') {
        sh 'ssh ec2-user@ip-172-31-12-174 "/home/ec2-user/trace/start.sh /home/ec2-user/trace/trace-1.0.0-RELEASE.jar prd"'
    }

}