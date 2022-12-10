

import 'package:ecom_app/core/exception/failure.dart';
import 'package:ecom_app/features/auth/login/data/dto/response/login_response.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ILoginService {
  Future<Result<LoginResponse,Failure>> login(Map<String,dynamic> request);
}