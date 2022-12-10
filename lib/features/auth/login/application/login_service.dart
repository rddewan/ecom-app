

import 'package:ecom_app/core/exception/failure.dart';
import 'package:ecom_app/core/local/db/hive_box_key.dart';
import 'package:ecom_app/features/auth/login/application/ilogin_service.dart';
import 'package:ecom_app/features/auth/login/data/repository/ilogin_repository.dart';
import 'package:ecom_app/features/auth/login/data/repository/login_repository.dart';
import 'package:ecom_app/features/setting/data/repository/setting_repository.dart';
import 'package:ecom_app/features/setting/data/repository/setting_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

final loginServiceProvider = Provider.autoDispose<ILoginService>((ref) {
  final loginRepository = ref.watch(loginRepositoryProvider);
  final settingRepository = ref.watch(settingRepositoryProvider);

  return LoginService(loginRepository,settingRepository);
  
});

class LoginService implements ILoginService {
 final ILoginRepository _loginRepository;
 final SettingRepository _settingRepository;

  LoginService(this._loginRepository, this._settingRepository);
 

  @override
  Future<Result<bool,Failure>> login(Map<String, dynamic> request) async {

    try {

      final response = await _loginRepository.login(request);

      final result = await  addToBox<String>(accessTokenKey, response.accessToken);

      return Success(result);    
      
    } on Failure catch (e) {
      return Error(e);    
    }

    
  }
  
  @override
  Future<bool> addToBox<T>(String key, T? value) async {
    try {

      return await _settingRepository.addToBox(key, value);
      
    } catch (e) {
        throw Failure(message: e.toString());  
    }
    
  }
  
  @override
  Future<Result<T?,Failure>> getFromBox<T>(String key) async {

    try {

      final result = await _settingRepository.getFromBox(key);
      return Success(result);
      
    } catch (e) {
      return Error(Failure(message: e.toString()));
      
    }
    
  }
  
}