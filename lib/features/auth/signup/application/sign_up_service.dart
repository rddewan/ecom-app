

import 'package:ecom_app/features/auth/signup/application/isign_up_service.dart';
import 'package:ecom_app/features/auth/signup/data/dto/sign_up_response.dart';
import 'package:ecom_app/features/auth/signup/data/repository/isign_up_repository.dart';
import 'package:ecom_app/features/auth/signup/data/repository/sign_up_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


/// provider to provide the instance of SignUpService
final signUpServiceProvider = Provider<ISignUpService>((ref) {
  final signUpRepository = ref.watch(signUpRepositoryProvider);

  return SignUpService(signUpRepository);

});

class SignUpService implements ISignUpService {
  final ISignUpRepository _signUpRepository;

  SignUpService(this._signUpRepository);
  

  @override
  Future<SignUpResponse> signUp(Map<String, dynamic> request) async {

    return await _signUpRepository.signUp(request);
    
  }
  
}