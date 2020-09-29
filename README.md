# Bolt Karate 

Karate is the only open-source tool to combine API test-automation, mocks, performance-testing and even UI automation into a single, unified framework. 
The BDD syntax popularized by Cucumber is language-neutral, and easy for even non-programmers. Powerful JSON & XML assertions are built-in, and you can run tests in parallel for speed.

Test execution and report generation feels like any standard Java project. But there's also a stand-alone executable for teams not comfortable with Java. You don't have to compile code. 
Just write tests in a simple, readable syntax - carefully designed for HTTP, 
JSON, GraphQL and XML. And you can mix API and UI test-automation within the same test script.

FEATURES
-----------
 - Java knowledge is not required and even non-programmers can write tests
 - Scripts are plain-text, require no compilation step or IDE, and teams can collaborate using Git / standard SCM
 - Based on the popular Cucumber / Gherkin standard - with IDE support and syntax-coloring options
 - Elegant DSL syntax 'natively' supports JSON and XML - including JsonPath and XPath expressions
 - Scripts can call other scripts - which means that you can easily re-use and maintain authentication and 'set up' flows efficiently, across multiple tests
 - Embedded JavaScript engine that allows you to build a library of re-usable functions that suit your specific environment or organization
 - Re-use of payload-data and user-defined functions across tests is so easy - that it becomes a natural habit for the test-developer
 - Built-in support for switching configuration across different environments (e.g. dev, QA, pre-prod)
 - Support for data-driven tests and being able to tag or group tests is built-in, no need to rely on an external framework
 
 COMPARISON WITH REST-assured 
 ----------------------------
 - For teams familiar with or currently using REST-assured, this detailed comparison of Karate vs REST-assured - can help you evaluate Karate.
    ref: (https://docs.google.com/document/d/1ETTrdMVcBXaPjdKY-_67zCWBsi2Ctc5DIQUIfr02H7A/edit)
    
    
PROJECT STRUCTURE
------------------

<build>
    <testResources>
        <testResource>
            <directory>src/test/java</directory>
            <excludes>
                <exclude>**/*.java</exclude>
            </excludes>
        </testResource>
    </testResources>        
    <plugins>
    ...
    </plugins>
</build>


JUNIT5
-------
We choosen that we used JUNIT 5 to this project, simpole because Karate supports JUnit 5 and the advantage is that you can have multiple methods in a test-class. 
Only 1 import is needed, and instead of a class-level annotation, you use a nice DRY and fluent-api to express which tests and tags you want to use.

EXECUTING THE PROJECT
----------------------

class KarateRunner {

    @Test
    public void testParallel() {
        Results results = Runner.parallel(getClass(), 5);
        generateReport(results.getReportDir());
        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);
        List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "BACKEND == BOLT == KARATE == APIs ");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
 - You can run the KarateRunner class, this will execute all the features that are created.
 - There are tests scenarios for DEV and UAT, they are ran at the same time in both environment.
 - You can run each feature file by select the specific one that you want to execute.
 
 
 JENKINS BUILD INTEGRATION
 -------------------------
 
 - This project is integrated with Bolt Jenkins.
 - Everytime you merge your PR it will kick off the build.
 - There is a scheduler that it runs every after four hours.
 
 
 REPORTING
 -----------

We are using cucumber extent report because Karate's integration includes the HTTP request and response logs in-line with the test report, which is extremely useful for troubleshooting test failures.

You can get it in the target folder after execution


























