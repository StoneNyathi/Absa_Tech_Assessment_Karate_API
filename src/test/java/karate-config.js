function fn() {
  var env = karate.env; // get system property 'karate.env'
  if (!env) {
    env = 'QA';
  }
  var config = {
    BOLTURL_BaseURL : 'https://api-uat.bolt.sdc-nonprod.caas.absa.co.za',
    BOLT_HEADER : '',
    VPN_proxy : '',
    Internet_proxy : '',

  }

  if (env == 'DEV') {
    config.BOLTURL_BaseURL = 'https://api-uat.bolt.sdc-nonprod.caas.absa.co.za';
    config.BOLT_HEADER = '';
    config.VPN_proxy = '';
    config.loginAuthURL =  '';
  }
  else if (env == 'QA') {
    config.BOLTURL_BaseURL = 'https://api-uat.bolt.sdc-nonprod.caas.absa.co.za';
    config.BOLT_HEADER = '';
    config.VPN_proxy = '';
    config.loginAuthURL =  '';
  }
  else if (env == 'STAGING'){
    config.BOLTURL_BaseURL = 'https://api-uat.bolt.sdc-nonprod.caas.absa.co.za/deal-api/api/deal/search/deal/?searchTerm=&stage=&dealer=&status=&dealType=&applicationType=&dealStatus=&startDate=2020-07-07&endDate=2020-07-07&page=0&sort=createDate,desc';
    config.BOLT_HEADER = '';
    config.VPN_proxy = '';
    config.loginAuthURL =  '';
  }

  karate.log("Environment is ::: "+env+" Base URL is ::: "+ config.BOLTURL_BaseURL);
  karate.configure('readTimeout', 6000000);
  karate.configure("connectTimeout", 50000);

  return config;
}