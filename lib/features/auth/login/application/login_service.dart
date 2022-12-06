

import 'package:ecom_app/features/auth/login/application/ilogin_service.dart';
import 'package:ecom_app/features/auth/login/data/dto/response/login_response.dart';
import 'package:ecom_app/features/auth/login/data/repository/ilogin_repository.dart';
import 'package:ecom_app/features/auth/login/data/repository/login_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginServiceProvider = Provider.autoDispose<ILoginService>((ref) {
  final loginRepository = ref.watch(loginRepositoryProvider);
  return LoginService(loginRepository);
  
});

class LoginService implements ILoginService {
 final ILoginRepository _loginRepository;

  LoginService(this._loginRepository);
 

  @override
  Future<LoginResponse> login(Map<String, dynamic> request) async {
    final response = await _loginRepository.login(request);
    return response;    
  }
  
}