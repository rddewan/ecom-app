

import 'package:ecom_app/features/auth/login/data/dto/response/login_response.dart';

abstract class ILoginService {
  Future<LoginResponse> login(Map<String,dynamic> request);
}