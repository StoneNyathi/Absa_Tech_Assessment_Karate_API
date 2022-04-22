function fn() {
  var env = karate.env; // get system property 'karate.env'
  if (!env) {
    env = 'QA';
  }
  var config = {

    URL_BaseURL : 'https://dog.ceo/api/breeds/',
    GATEWAY_URL : '',
    BaseURL : '',
    BOLT_HEADER : '',
    VPN_proxy : '',
    Internet_proxy : '',

  }

  if (env == 'DEV') {
    config.BaseURL = 'https://dog.ceo/api/breeds/'
    config.GATEWAY_URL_DEV = ''
    config.BOLT_HEADER = '';
    config.VPN_proxy = '';
    config.loginAuthURL =  '';
  }
  else if (env == 'QA') {
    config.URL_BaseURL = 'https://dog.ceo/api/breeds/'
    config.GATEWAY_URL = 'https://dog.ceo/api/breeds/'
    config.BOLT_HEADER = '';
    config.VPN_proxy = '';
    config.loginAuthURL =  '';
  }
  else if (env == 'STAGING'){
    config.URL_BaseURL = '';
    config.BaseURL = ''
    config.BOLT_HEADER = '';
    config.VPN_proxy = '';
    config.loginAuthURL =  '';
  }

  karate.log("Environment is ::: "+env+" Base URL is ::: "+ config.URL_BaseURL);
  karate.configure('readTimeout', 6000000);
  karate.configure("connectTimeout", 50000);
  karate.configure('ssl', true);

  return config;
}