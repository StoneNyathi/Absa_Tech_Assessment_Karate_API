// /**
//  *  I highly recommend to use it because it will improve the mantainability and readability of our Karate features
//  */
// // function fn() {
// //
// //     var environment = karate.properties['env'];
// //     if(!environment) {
// //         environment = 'localhost'
// //     }
// //
// //     var port = karate.properties['port'];
// //     if(!port) {
// //         port = '8082'
// //     }
// //
// //     return {
// //         apiBasePath: 'http://' + environment + ':' + port + '/tasklist-management/api'
// //     };
// // }
//
// function() {
//     var env = karate.env; // get system property 'karate.env'
//     karate.log('karate.env system property was:', env);
//     if (!env) {
//         env = 'dev';
//     }
//     var config = {
//         env: env,
//         myVarName: 'someValue'
//     }
//     if (env == 'dev') {
//         karate.configure('connectTimeout', 20000);
//         karate.configure('readTimeout', 20000);
//     } else if (env == 'e2e') {
//         // customize
//     }
//     karate.configure('connectTimeout', 30000);
//     karate.configure('readTimeout', 30000);
//     return config;
// }