
import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied(path: '.dev.env')
abstract class EnvDev {
  @EnviedField(varName: 'BASE_URL')
  static const baseUrl = _EnvDev.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final apiKey = _EnvDev.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final certificate = _EnvDev.certificate;

}

@Envied(path: '.qa.env')
abstract class EnvQA {
  @EnviedField(varName: 'BASE_URL')
  static const baseUrl = _EnvQA.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final apiKey = _EnvQA.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final certificate = _EnvDev.certificate;
}

@Envied(path: '.uat.env')
abstract class EnvUAT {
  @EnviedField(varName: 'BASE_URL')
  static const baseUrl = _EnvUAT.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final apiKey = _EnvUAT.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final certificate = _EnvDev.certificate;

}

@Envied(path: '.prod.env')
abstract class EnvProd {
  @EnviedField(varName: 'BASE_URL')
  static const baseUrl = _EnvProd.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final apiKey = _EnvProd.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final certificate = _EnvDev.certificate;

}