//package karatepoc.performance
//
//import com.intuit.karate.junit4.Karate
//import io.gatling.core.Predef._
////import org.scalatest.FeatureSpec
//import com.intuit.karate.gatling.PreDef.karateFeature
//import scala.concurrent.duration._
//import scala.language.postfixOps
//
//class UserSimulation extends Simulation {
//  val getSingleDeal = scenario( scenarioName = "Getting specific deal details").exec(karateFeature("classpath:performance/Bolt_Search.feature"))
//
//  setUp(
//    getSingleDeal.inject(rampUsers(users = 10).during(10 seconds))
//  )
//}