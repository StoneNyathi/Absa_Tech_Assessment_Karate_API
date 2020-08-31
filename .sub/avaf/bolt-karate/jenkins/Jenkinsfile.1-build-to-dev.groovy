properties([buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '1')), durabilityHint('PERFORMANCE_OPTIMIZED')])
def label = "worker-${UUID.randomUUID().toString()}"

def registryCredentialSecretName = "regcred"

languagePack = "java11"

kubeconfigDir = "/kubeconfigs"

subatomicTeamName = "bolt"
subatomicProjectName = "avaf"
subatomicAppName = "bolt-karate"
subatomicHomeFolder = ".sub/${subatomicProjectName}/${subatomicAppName}"
hasIngress = false

nonprodClusters = [
    [
        name: "avaf-nonprod-270",
        fqdn: "bolt.270-nonprod.caas.absa.co.za",
        kubeconfigConfigmapName: "avaf-nonprod-270-kubeconfig"
    ], 
    [
        name: "avaf-nonprod-sdc",
        fqdn: "bolt.sdc-nonprod.caas.absa.co.za",
        kubeconfigConfigmapName: "avaf-nonprod-sdc-kubeconfig"
    ]
]

nonprodEnvironments = ["dev"]

prodClusters = [
    [
        name: "avaf-prod-270",
        fqdn: "bolt.270-prod.caas.absa.co.za",
        kubeconfigConfigmapName: "avaf-prod-270-kubeconfig"
    ], 
    [
        name: "avaf-prod-sdc",
        fqdn: "bolt.sdc-prod.caas.absa.co.za",
        kubeconfigConfigmapName: "avaf-prod-sdc-kubeconfig"
    ]
]

prodEnvironments = []

// Initialise docker registry details initializeJenkinsConfig
initializeJenkinsConfig()

def initializeJenkinsConfig() {
    withCredentials([string(credentialsId: 'sub-jenkins-config', variable: 'SUB_JENKINS_CONFIG_RAW')]) {
        def subJenkinsConfig = new groovy.json.JsonSlurper().parseText("${SUB_JENKINS_CONFIG_RAW}")

        baseDockerRegistry = subJenkinsConfig.containerRegistry.activeRegistry
        dockerPushProject = "${baseDockerRegistry}/${subatomicTeamName}"
        dockerPullProject = "${baseDockerRegistry}/bison-cloud"
    }
}

def getValueFileOption(valuesFileName) {
    def valuesFilePath = "${subatomicHomeFolder}/charts/${valuesFileName}"
    if (fileExists(valuesFilePath)) {
        return "--values ${valuesFilePath}"
    } else {
        return ""
    }
}

def getAllValueFileOptions(environment, clusterName) {
    def defaultValues = getValueFileOption("values.yaml")
    def environmentValues = getValueFileOption("values-${environment}.yaml")
    def clusterValues = getValueFileOption("values-${environment}-${clusterName}.yaml")
    def valuesFiles = "${defaultValues} \
        ${environmentValues} \
        ${clusterValues}"

    return valuesFiles
}

def logMetrics(message) {
    log("[${subatomicTeamName}, ${subatomicProjectName}, ${subatomicAppName}, ${JOB_URL}, ${BRANCH_NAME}, ${BUILD_NUMBER}] - ${message}")
}

def log(message) {
    def now = new Date().format("yyyy-MM-dd'T'HH:mm:ss'Z'", TimeZone.getTimeZone("UTC"))
    echo "[${now}][Subatomic] - ${message}"
}

def logStage(stageName) {
    def line = "-".multiply("Stage: ${stageName}".length())
    echo "${line}\nStage: ${stageName}\n${line}"
    logMetrics("Stage ${stageName} started")
}

logMetrics("Jenkins Job Started")

podTemplate(label: label, containers: [
    containerTemplate(name: 'maven', image: dockerPullProject + '/sub-maven-3-jdk-11:latest', command: 'cat', ttyEnabled: true, alwaysPullImage: true),
    containerTemplate(name: 'kaniko', image: dockerPullProject + '/kaniko:debug-v0.17.1', command: 'cat', ttyEnabled: true),
    containerTemplate(name: 'sub-build-tools', image: dockerPullProject + '/sub-build-tools:v2', command: 'cat', ttyEnabled: true, alwaysPullImage: true),
], 
volumes: [
    secretVolume(mountPath: '/docker/auth/', secretName: "${registryCredentialSecretName}"),
    emptyDirVolume(mountPath: '${kubeconfigDir}', memory: false)
],
imagePullSecrets: ["${registryCredentialSecretName}"]){
    node(label) {
        // Please do not remove this
        logMetrics("Jenkins Worker Scheduled")

        stage('Prepare') {
            logStage("Prepare")
            container("sub-build-tools") {
                log("Mount kubeconfigs needed for deployment to external clusters")
                nonprodClusters.each { cluster ->
                    sh "sub_build_tools kube mount-configmap --configmap_name=${cluster.kubeconfigConfigmapName} --destination_dir='${kubeconfigDir}'"
                }
                prodClusters.each { cluster ->
                    sh "sub_build_tools kube mount-configmap --configmap_name=${cluster.kubeconfigConfigmapName} --destination_dir='${kubeconfigDir}'"
                }
            }
        }

        def myRepo = checkout scm
        def gitCommit = myRepo.GIT_COMMIT
        def shortGitCommit = "${gitCommit[0..10]}"
        def baseImageTag = "${BUILD_NUMBER}-${shortGitCommit}"

        def summary;
        lock('Tests') {
            stage('Test') {
                container('maven') {
                    sh "mkdir -p ~/.m2"
                    sh "echo '<settings>\n" +
                            "  <mirrors>\n" +
                            "    <mirror>\n" +
                            "      <id>bison-nexus</id>\n" +
                            "      <mirrorOf>*</mirrorOf>\n" +
                            "      <name>BISON Nexus mirror</name>\n" +
                            "      <url>http://nexus.prod.ocp.absa.co.za/repository/public-repositories/</url>\n" +
                            "    </mirror>\n" +
                            "  </mirrors>" +
                            "</settings>' > ~/.m2/settings.xml"

                    // 6. Run the acceptance tests
                    checkout(scm)
                    try {
                        sh ': Run tests && mvn --batch-mode test '
                    } catch (e) {
                        currentBuild.result = "FAILURE"
                    } finally {
                        summary = junit 'target/surefire-reports/*.xml'
                    }
                }
            }
            stage('Notification') {
                if (summary) {
                    slackSend channel: '#avaf-bolt-integration', color: summary.failCount == 0 ? 'good' : 'warning', message: "Executed ${env.JOB_NAME}. Failures ${summary.failCount}"
                }
            }
        }

        // Please do not remove this
        logMetrics("Jenkins Job Completed")
    }
}
