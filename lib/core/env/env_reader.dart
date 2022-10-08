
import 'dart:convert';

import 'package:ecom_app/core/env/env.dart';
import 'package:ecom_app/core/flavor/flavor.dart';
import 'package:ecom_app/core/providers/flavor_provider.dart';
import 'package:flutter/foundation.dart';
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

  Uint8List getCertificate() {
    switch (_flavor) {
      case Flavor.dev:
        return base64Decode(EnvDev.certificate);
      case Flavor.qa:
        return base64Decode(EnvQA.certificate);
      case Flavor.uat:
        return base64Decode(EnvUAT.certificate);
      case Flavor.prod:
        return base64Decode(EnvProd.certificate);        
      default:
        throw Exception(".env file not found");
    }
  }

  String getAndroidBuildId() {
    switch (_flavor) {
      case Flavor.dev:
        return EnvDev.androidBuildId;
      case Flavor.qa:
        return EnvQA.androidBuildId;
      case Flavor.uat:
        return EnvUAT.androidBuildId;
      case Flavor.prod:
        return EnvProd.androidBuildId;        
      default:
        throw Exception(".env file not found");
    }
  }

  String getIosBuildId() {
    switch (_flavor) {
      case Flavor.dev:
        return EnvDev.iosBuildId;
      case Flavor.qa:
        return EnvQA.iosBuildId;
      case Flavor.uat:
        return EnvUAT.iosBuildId;
      case Flavor.prod:
        return EnvProd.iosBuildId;        
      default:
        throw Exception(".env file not found");
    }
  }

  String egtHash256() {
    switch (_flavor) {
      case Flavor.dev:
        return utf8.decode(base64Decode(EnvDev.hash256));
      case Flavor.qa:
        return utf8.decode(base64Decode(EnvQA.hash256));
      case Flavor.uat:
        return utf8.decode(base64Decode(EnvUAT.hash256));
      case Flavor.prod:
        return utf8.decode(base64Decode(EnvProd.hash256));        
      default:
        throw Exception(".env file not found");
    }
  }
  
}