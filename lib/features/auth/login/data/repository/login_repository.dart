
import 'package:ecom_app/features/auth/login/data/api/login_api_service.dart';
import 'package:ecom_app/features/auth/login/data/dto/response/login_response.dart';
import 'package:ecom_app/features/auth/login/data/repository/ilogin_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginRepositoryProvider = Provider.autoDispose<ILoginRepository>((ref) {
  final loginApiService = ref.watch(loginApiServiceProvider);

  return LoginRepository(loginApiService);

});

class LoginRepository implements ILoginRepository {
  final LoginApiService _loginApiService;

  LoginRepository(this._loginApiService);

  @override
  Future<LoginResponse> login(Map<String, dynamic> request) async {

    return await _loginApiService.login(request);
   
  }
  
}