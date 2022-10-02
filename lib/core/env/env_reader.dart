
import 'package:ecom_app/core/env/env.dart';
import 'package:ecom_app/core/flavor/flavor.dart';
import 'package:ecom_app/core/providers/flavor_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final envReaderProvider = Provider<EnvReader>((ref) {
  final flavor = ref.watch(flavorProvider);

  return EnvReader(flavor);

});

class EnvReader {
  final Flavor _flavor;

  EnvReader(this._flavor);

  String getBaseUrl() {
    switch (_flavor) {
      case Flavor.dev:
        return EnvDev.baseUrl;
      case Flavor.qa:
        return EnvQA.baseUrl;
      case Flavor.uat:
        return EnvUAT.baseUrl;
      case Flavor.prod:
        return EnvProd.baseUrl;        
      default:
        throw Exception(".env file not found");
    }
  }

  String getApiKey() {
    switch (_flavor) {
      case Flavor.dev:
        return EnvDev.apiKey;
      case Flavor.qa:
        return EnvQA.apiKey;
      case Flavor.uat:
        return EnvUAT.apiKey;
      case Flavor.prod:
        return EnvProd.apiKey;        
      default:
        throw Exception(".env file not found");
    }
  }
  
}