package za.co.absa.bolt.avaf.ebo.seriti;

import com.intuit.karate.junit5.Karate;

class SeritiRunner {

    @Karate.Test
    Karate testIndividualStandardFeature(){
        return new Karate().feature("individual/individual_with_standard.feature").relativeTo(getClass());
    }

   @Karate.Test
   Karate testIntegration(){
       return new Karate().tags("@smoke").relativeTo(getClass());
   }

   @Karate.Test
   Karate testFullPath(){
       return new Karate()
               .feature("classpath:za/co/absa/bolt/avaf/ebo/seriti/individual/individual_with_standard.feature")
               .tags("@version=2.3");
   }
}
