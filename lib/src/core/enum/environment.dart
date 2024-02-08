// import 'package:select_annotation/select_annotation.dart';

// part 'environment.select.dart';

// @matchable
// enum Environment {
//   production,
//   staging,
//   development,
// }

const String kBaseUrl = 'https://products.halyklife.kz/test/gateway';

const String kPolisesWebUrl =
    'https://mobile.halyklife.kz/test/policies?source=mobile&jwt=';
const String kInsuranceWebUrl =
    'https://lk-mobile.vercel.app/insurance?source=mobile&jwt=';
String kHomeWebUrl(String locale) {
  return 'https://mobile.halyklife.kz/test/home?source=mobile&lang=$locale';
}

// const String kHomeWebUrl =
//     'https://mobile.halyklife.kz/test/home?source=mobile&?lang=kaz';
// const String kHomeWebUrlWithoutJWT =
//     'https://mobile.halyklife.kz/home?source=mobile&jwt=null';
// const String kHomeWebUrlEmpty = 'https://mobile.halyklife.kz/home';
const String kCallCenter = '7123';
const String kWhatsappNumber = '77007489650';
const String kTelegramNumber = 'halyklife_kz';


// // const String kDevBaseUrl = 'http://185.116.194.153:8081';
