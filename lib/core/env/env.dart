
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
  @EnviedField(varName: 'ANDROID_BUILD_ID')
  static const androidBuildId = _EnvDev.androidBuildId;
  @EnviedField(varName: 'IOS_BUILD_ID')
  static const iosBuildId = _EnvDev.iosBuildId;
  @EnviedField(varName: 'HASH256', obfuscate: true)
  static final hash256 = _EnvDev.hash256;

}

@Envied(path: '.qa.env')
abstract class EnvQA {
  @EnviedField(varName: 'BASE_URL')
  static const baseUrl = _EnvQA.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final apiKey = _EnvQA.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final certificate = _EnvQA.certificate;
  @EnviedField(varName: 'ANDROID_BUILD_ID')
  static const androidBuildId = _EnvQA.androidBuildId;
  @EnviedField(varName: 'IOS_BUILD_ID')
  static const iosBuildId = _EnvQA.iosBuildId;
  @EnviedField(varName: 'HASH256', obfuscate: true)
  static final hash256 = _EnvQA.hash256;
}

@Envied(path: '.uat.env')
abstract class EnvUAT {
  @EnviedField(varName: 'BASE_URL')
  static const baseUrl = _EnvUAT.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final apiKey = _EnvUAT.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final certificate = _EnvUAT.certificate;
  @EnviedField(varName: 'ANDROID_BUILD_ID')
  static const androidBuildId = _EnvUAT.androidBuildId;
  @EnviedField(varName: 'IOS_BUILD_ID')
  static const iosBuildId = _EnvUAT.iosBuildId;
  @EnviedField(varName: 'HASH256', obfuscate: true)
  static final hash256 = _EnvUAT.hash256;

}

@Envied(path: '.prod.env')
abstract class EnvProd {
  @EnviedField(varName: 'BASE_URL')
  static const baseUrl = _EnvProd.baseUrl;
  @EnviedField(varName: 'API_KEY', obfuscate: true)
  static final apiKey = _EnvProd.apiKey;
  @EnviedField(varName: 'CERTIFICATE', obfuscate: true)
  static final certificate = _EnvProd.certificate;
  @EnviedField(varName: 'ANDROID_BUILD_ID')
  static const androidBuildId = _EnvProd.androidBuildId;
  @EnviedField(varName: 'IOS_BUILD_ID')
  static const iosBuildId = _EnvProd.iosBuildId;
  @EnviedField(varName: 'HASH256', obfuscate: true)
  static final hash256 = _EnvProd.hash256;

}