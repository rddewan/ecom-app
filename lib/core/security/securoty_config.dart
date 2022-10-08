

import 'dart:io';

import 'package:ecom_app/core/env/env_reader.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freerasp/talsec_app.dart';
import 'package:freerasp/utils/hash_converter.dart';

final securityConfigProvider = Provider<SecurityConfig>((ref) {
  final envReader = ref.watch(envReaderProvider);

  return SecurityConfig(ref, envReader);

});

class SecurityConfig {
  final Ref _ref;
  final EnvReader _envReader;

  SecurityConfig(this._ref, this._envReader) {
    _init();
  }

  
  void _init() async {
    // Signing hash of your app
    final hash256 = _envReader.egtHash256();
    String base64Hash = hashConverter.fromSha256toBase64(hash256);

    TalsecConfig config = TalsecConfig(

      // For Android
      androidConfig: AndroidConfig(
        expectedPackageName: _envReader.getAndroidBuildId(),
        expectedSigningCertificateHash: base64Hash,
        supportedAlternativeStores: ["com.sec.android.app.samsungapps"],
      ),

      // For iOS
      iosConfig: IOSconfig(
        appBundleId: _envReader.getIosBuildId(),
        appTeamId: 'FCUZNYGQMQ',
      ),

      // Common email for Alerts and Reports
      watcherMail: 'your_mail@example.com',

      
  );

    // Talsec callback handler
    TalsecCallback callback = TalsecCallback(
      // For Android
      androidCallback: AndroidCallback(
        onRootDetected: ()  {

        },
        onEmulatorDetected: () async {          
          //exit(0);
          await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
        },
        onHookDetected: () {

        },
        onTamperDetected: () {

        },
        onDeviceBindingDetected: () {

        },
        onUntrustedInstallationDetected: ()  {

        },
      ),
      // For iOS
      iosCallback: IOSCallback(
          onSignatureDetected: () {

          },
          onRuntimeManipulationDetected: () {

          },
          onJailbreakDetected: () {

          },
          onPasscodeDetected: () async {
            await SystemChannels.platform.invokeMethod<void>('SystemNavigator.pop');
            exit(0);
          },
          onSimulatorDetected: () {

          },
          onMissingSecureEnclaveDetected: () {

          },
          onDeviceChangeDetected: () {

          },
          onDeviceIdDetected: () => {

          },
          onUnofficialStoreDetected: () {

          },
      ),
      // Common for both platforms
      onDebuggerDetected: () {

      },
      
    );
  
    TalsecApp app = TalsecApp(
      config: config,
      callback: callback,
    );

    app.start();
  }

}