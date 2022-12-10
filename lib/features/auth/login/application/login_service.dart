

import 'package:ecom_app/core/exception/failure.dart';
import 'package:ecom_app/features/auth/login/application/ilogin_service.dart';
import 'package:ecom_app/features/auth/login/data/dto/response/login_response.dart';
import 'package:ecom_app/features/auth/login/data/repository/ilogin_repository.dart';
import 'package:ecom_app/features/auth/login/data/repository/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';

final loginServiceProvider = Provider.autoDispose<ILoginService>((ref) {
  final loginRepository = ref.watch(loginRepositoryProvider);
  return LoginService(loginRepository);
  
});

class LoginService implements ILoginService {
 final ILoginRepository _loginRepository;

  LoginService(this._loginRepository);
 

  @override
  Future<Result<LoginResponse,Failure>> login(Map<String, dynamic> request) async {

    try {

      final response = await _loginRepository.login(request);
      return Success(response);    
      
    } on Failure catch (e) {
      return Error(e);    
    }

    
  }
  
}