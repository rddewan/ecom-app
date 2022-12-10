

import 'package:ecom_app/core/exception/failure.dart';
import 'package:ecom_app/features/auth/signup/data/dto/sign_up_response.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ISignUpService {
  Future<Result<SignUpResponse,Failure>> signUp(Map<String,dynamic> request);
}