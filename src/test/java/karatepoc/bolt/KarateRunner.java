//package karatepoc.bolt;
//
//import com.intuit.karate.Results;
//import com.intuit.karate.Runner;
////import com.intuit.karate.junit5.Karate;
//import net.masterthought.cucumber.ReportBuilder;
//import static org.junit.jupiter.api.Assertions.assertEquals;
//import static org.junit.jupiter.api.Assertions.assertNotEquals;
//import static org.junit.jupiter.api.Assertions.assertTrue;
//
//import java.io.File;
//import java.util.ArrayList;
//import java.util.Collection;
//import java.util.List;
//import net.masterthought.cucumber.Configuration;
//import org.apache.commons.io.FileUtils;
//import org.junit.jupiter.api.Test;
//
//
//class KarateRunner {
//
//   /* @Karate.Test
//    Karate testUsers() {
//        return Karate.run("/feature/bolt_search").relativeTo(getClass());
//    }*/
//
//    @Test
//    public void testParallel() {
//        //System.setProperty("karate.env", "demo"); // ensure reset if other tests (e.g. mock) had set env in CI
//        Results results = Runner.parallel(getClass(), 5);
//        generateReport(results.getReportDir());
//        assertTrue(results.getFailCount() == 0, results.getErrorMessages());
//    }
//
//    public static void generateReport(String karateOutputPath) {
//        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
//        List<String> jsonPaths = new ArrayList<String>(jsonFiles.size());
//        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
//        Configuration config = new Configuration(new File("target"), "BACKEND == BOLT == KARATE == APIs ");
//        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
//        reportBuilder.generateReports();
//    }
//
//}
