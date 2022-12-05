

import 'package:ecom_app/features/auth/signup/data/dto/sign_up_response.dart';

abstract class ISignUpService {
  Future<SignUpResponse> signUp(Map<String,dynamic> request);
}