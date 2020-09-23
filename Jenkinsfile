/**
 * Jenkins pipeline to build an application with the GitHub flow in mind (https://guides.github.com/introduction/flow/).
 *
 */
properties([buildDiscarder(logRotator(numToKeepStr: '10', artifactNumToKeepStr: '1')), durabilityHint('PERFORMANCE_OPTIMIZED')])

podTemplate(containers: [
    // For why we use `command: cat, ttyEnabled: true`, see https://github.com/jenkinsci/kubernetes-plugin#constraints
    containerTemplate(name: 'maven', image: 'harbor-sdc.caas.absa.co.za/library/maven-absa:3.6.1-jdk-11-slim', command: 'cat', ttyEnabled: true)
]) {
	node(POD_LABEL) {

		stage('Test and Build') {
			container('maven') {
              checkout(scm)
              sh 'mkdir -p ~/.m2'
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

				try {

					sh ': Run smoke tests && mvn test -Dtest=KarateRunner'

				} finally {
					echo "add reporting"
				}
   			 }
  		}
 	 }
         post {
                 always {
                     cucumber '**/cucumber.json'
                 }
             }
}