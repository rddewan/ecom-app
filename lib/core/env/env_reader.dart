

import 'package:ecom_app/flavors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvReader {

  String getEnvFileName(Flavor flavor) {
    switch (flavor) {
      case Flavor.DEV:
        return ".dev.env";
      case Flavor.QA:
        return ".qa.env";
      case Flavor.UAT:
        return ".uat.env";
      case Flavor.PROD:
        return ".prod.env";
        
      default:
        throw Exception(".env file not found");
    }

  }

  String getBaseUrl() {
    return dotenv.get('BASE_URL');
  }

  String getApiKey() {
    return dotenv.get('API_KEY');
  }
}