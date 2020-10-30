
def notifyBuild(String buildStatus = 'STARTED', String message = '') {
  // build status of null means successful
  buildStatus =  buildStatus ?: 'SUCCESSFUL'

  // Default values
  def colorName = 'RED'
  def colorCode = '#FF0000'
  def subject = "${buildStatus}: Job '${env.JOB_NAME} [${env.BUILD_NUMBER}]'"
  def summary = "${subject} (${env.BUILD_URL}) ${message}"

  // Override default values based on build status
  if (buildStatus == 'STARTED' || buildStatus == 'MESSAGE') {
    color = 'YELLOW'
    colorCode = '#FFFF00'
  } else if (buildStatus == 'SUCCESSFUL') {
    color = 'GREEN'
    colorCode = '#00FF00'
  } else {
    color = 'RED'
    colorCode = '#FF0000'
  }

  // Send notifications
  slackSend (color: colorCode, message: summary)
}
def buildPath(String buildPath){

  notifyBuild('Generating Templates')
    container('builder') {   
      dir(buildPath){
        sh("export BUILDTAG=${COMMIT}; export BRANCH_NAME=${env.BRANCH_NAME}; make template-without-secrets")
      }
    }
    notifyBuild("Templates Done " + buildPath)
} 
def buildImagePath(String buildPath, String imageName){
  container('docker') {
    docker.withRegistry('https://us.gcr.io', 'gcr:st2dio') {
      app = docker.build("${imageName}" , "${buildPath}")  
      sh("docker push ${imageName}")
    }
  }
}
pipeline {
  environment {
    COMMIT = sh(returnStdout: true, script: "git log -n 1 --pretty=format:'%h'").trim()
    PROJECT = "redskysec"
    APP_NAME = "redteamz"
    FE_SVC_NAME = "${APP_NAME}"
    CLUSTER = "jenkins-cd"
    CLUSTER_ZONE = "us-east1-b"
    IMAGE_TAG = "us.gcr.io/${PROJECT}/${APP_NAME}:${COMMIT}"
    JENKINS_CRED = "${PROJECT}"
    ENVSPACE = "${env.APP_NAME}-${env.BRANCH_NAME}"

    PATH_SERVERS_BASE = "${env.WORKSPACE}/SERVERS"

    PATH_SERVERS_BASE_GOPHISH = "${PATH_SERVERS_BASE}/PHISHING/gophish"
    IMAGE_TAG_GOPHISH = "us.gcr.io/${PROJECT}/${APP_NAME}-gophish:${COMMIT}"

    PATH_SERVERS_BASE_BEEF = "${PATH_SERVERS_BASE}/C2C/beef"
    IMAGE_TAG_BEEF = "us.gcr.io/${PROJECT}/${APP_NAME}-beef:${COMMIT}"



  }
  agent {
    kubernetes {
      //label "st2dio"
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
  jenkins: slave
spec:
  # Use service account that can deploy to all namespaces
  serviceAccountName: cd-jenkins
  imagePullSecrets:
        - name: gcr-json-key 
  containers:

  - name: gcloud
    image: gcr.io/cloud-builders/gcloud
    command:
    - cat
    tty: true
    volumeMounts:
    - name: deployer
      mountPath: /secret/deployer.json
      subPath: deployer.json
      readOnly: true
      
    
  - name: kubectl
    image: gcr.io/cloud-builders/kubectl
    command:
    - cat
    tty: true
    volumeMounts:
    - name: kubeconf
      mountPath: /root/.kube/config
      subPath: kubeconf
      readOnly: true
       
  - name: git
    image: gcr.io/cloud-builders/git
    command:
    - cat
    tty: true

  - name: builder
    image:  us.gcr.io/bzrstores/builder:latest
    imagePullPolicy: Always    
    command:
    - cat
    tty: true
    volumeMounts:
    - name: deploy-gpgkey
      mountPath: /secret/deploy.keys.pvt
      subPath: deploy.keys.pvt
      readOnly: true

    - name: linode-sshkey
      mountPath: /root/.ssh/id_rsa
      subPath: id_rsa
      readOnly: true

  - name: docker
    image: docker:latest
    command:
    - cat
    tty: true
    volumeMounts:
    - mountPath: /var/run/docker.sock
      name: docker-sock
  
  volumes:
    - name: docker-sock
      hostPath:
        path: /var/run/docker.sock
    - name: deploy-gpgkey
      secret:
        secretName: deploy-gpgkey
    - name: linode-sshkey
      secret:
        secretName: linode-sshkey
    - name: kubeconf
      secret:
        secretName: kubeconf
    - name: deployer
      secret:
        secretName: gcp-deployer
"""
    }
  }

  stages {
    stage('notify'){
      steps {
        notifyBuild('STARTED')
      }
    }
    stage('CHECKOUT SCM') {
      steps {
        notifyBuild('checkout scm')
      }
    }
    stage('Docker Builds') {
      steps {
        notifyBuild('Build Docker')
        script {
           buildImagePath(PATH_SERVERS_BASE_BEEF, IMAGE_TAG_BEEF)
           buildImagePath(PATH_SERVERS_BASE_GOPHISH, IMAGE_TAG_GOPHISH)

        }
      }  
   }
   
   stage('Deploy staging K8s ') {
      steps {
       script {
          container('builder') {   
            }        
         notifyBuild("Deploy ${env.BRANCH_NAME} start")
         dir("${env.WORKSPACE}/staging"){
           sh "pwd"
           container('kubectl'){       

                sh("export BUILDTAG=${env.GIT_COMMIT};\
               kubectl apply -f tmp-k8s/;")

              if( "${env.BRANCH_NAME}" == "staging" ) {       
               sh("export BUILDTAG=${env.GIT_COMMIT};\
               kubectl delete -f tmp-k8s/;")
             
             }
           }
         }
       }
     }
   }


   //  stage('Generate public portal K8s Templates') {
   //    steps {
   //      notifyBuild('Starting K8s public nginx builds')
   //      script {
   //          notifyBuild('Generating Templates')
   //            container('builder') {   
   //              dir(){
   //                sh("export BUILDTAG=${COMMIT}; export BRANCH_NAME=${env.BRANCH_NAME}; make template-without-secrets")
   //              }
   //            }
   //            notifyBuild("Templates Done")
   //      }
   //    }  
   // }


    // stage('Deploy static sites K8s ') {
    //   steps {
    //     script {
        
    //       notifyBuild("Deploy ${env.BRANCH_NAME} start")
    //       dir("${env.WORKSPACE}/public"){
    //         container('kubectl'){  
    //           if( "${env.BRANCH_NAME}" == "master"  ) {
    //             notifyBuild('applying kube spec of master to tooling')
    //             container('kubectl'){
    //               container('gcloud'){              
    //               sh('gcloud auth activate-service-account --key-file=/secret/deployer.json && gcloud container clusters get-credentials stores-001a --zone us-central1-c --project bzrstores')
    //               sh("kubectl apply -f tmp-k8s/ ")
    //               }
    //             }
    //             notifyBuild('SUCCESSFUL')
    //           }
    //           sh('rm -rf tmp-k8s')
    //         }
    //       }
    //     }
    //   }
    // }


    stage('Finally') {
      steps {
        notifyBuild('DONE')
      }
    }
  } 
}

      
