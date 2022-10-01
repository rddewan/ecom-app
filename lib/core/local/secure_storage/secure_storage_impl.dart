
import 'package:ecom_app/core/local/secure_storage/flutter_secure_storage_provider.dart';
import 'package:ecom_app/core/local/secure_storage/secure_storage.dart';
import 'package:ecom_app/core/local/secure_storage/secure_storage_const.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

final secureStorageProvider = Provider<SecureStorage>((ref) {
  final flutterSecureStorage = ref.watch(flutterSecureStorageProvider);

  return SecureStorageIpl(flutterSecureStorage);

});

class SecureStorageIpl implements SecureStorage {
  final FlutterSecureStorage _flutterSecureStorage;

  SecureStorageIpl(this._flutterSecureStorage);

  
  @override
  Future<String?> getHiveKey() async{
    return await _flutterSecureStorage.read(key: hiveKey);
   }

  @override
  Future<void> setHiveKey(String value) async{
    await _flutterSecureStorage.write(key: hiveKey, value: value);
    
  }

}