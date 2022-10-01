
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final flutterSecureStorageProvider = Provider<FlutterSecureStorage>((ref) {

  AndroidOptions _androidOptions = const AndroidOptions(
        encryptedSharedPreferences: true,
  );

  IOSOptions _iosOptions = const IOSOptions(
    accessibility: KeychainAccessibility.first_unlock,
  );

  return  FlutterSecureStorage(
    aOptions: _androidOptions,
    iOptions: _iosOptions,
  );
});