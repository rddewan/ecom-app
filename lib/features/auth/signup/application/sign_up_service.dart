

import 'package:ecom_app/core/exception/failure.dart';
import 'package:ecom_app/features/auth/signup/application/isign_up_service.dart';
import 'package:ecom_app/features/auth/signup/data/dto/sign_up_response.dart';
import 'package:ecom_app/features/auth/signup/data/repository/isign_up_repository.dart';
import 'package:ecom_app/features/auth/signup/data/repository/sign_up_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';


/// provider to provide the instance of SignUpService
final signUpServiceProvider = Provider<ISignUpService>((ref) {
  final signUpRepository = ref.watch(signUpRepositoryProvider);

  return SignUpService(signUpRepository);

});

class SignUpService implements ISignUpService {
  final ISignUpRepository _signUpRepository;

  SignUpService(this._signUpRepository);
  

  @override
  Future<Result<SignUpResponse,Failure>> signUp(Map<String, dynamic> request) async {

    try {

      final response = await _signUpRepository.signUp(request);
      return Success(response);
      
    } on Failure catch (e) {
      return Error(e);    
    }
    
    
  }
  
}