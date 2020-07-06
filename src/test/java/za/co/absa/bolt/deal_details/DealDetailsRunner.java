package za.co.absa.bolt.deal_details;

import com.intuit.karate.junit5.Karate;

class DealDetailsRunner {

    @Karate.Test
    Karate testDealDetailsFeature(){
        return new Karate().feature("deal_details.feature").relativeTo(getClass());
    }

   @Karate.Test
   Karate testIntegration(){
       return new Karate().tags("@smoke").relativeTo(getClass());
   }

   @Karate.Test
   Karate testFullPath(){
       return new Karate()
               .feature("classpath:za/co/absa/bolt/deal_details/deal_details.feature")
               .tags("@version=2.3");
   }
}
