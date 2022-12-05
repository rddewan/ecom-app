

import 'package:ecom_app/features/auth/signup/data/api/sign_up_api_service.dart';
import 'package:ecom_app/features/auth/signup/data/dto/sign_up_response.dart';
import 'package:ecom_app/features/auth/signup/data/repository/isign_up_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// provider to provide the instance of SignUpRepository
final signUpRepositoryProvider = Provider<ISignUpRepository>((ref) {
  final signUpApiService = ref.watch(signUpApiServiceProvider);

  return SignUpRepository(signUpApiService);

});

class SignUpRepository implements ISignUpRepository {
  final SignUpApiService _signUpApiService;

  SignUpRepository(this._signUpApiService); 


  @override
  Future<SignUpResponse> signUp(Map<String, dynamic> request) async {
    return await _signUpApiService.signUp(request);
    
  }
  
}