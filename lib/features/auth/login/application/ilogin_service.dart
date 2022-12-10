

import 'package:ecom_app/core/exception/failure.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class ILoginService {
  Future<Result<bool,Failure>> login(Map<String,dynamic> request);
  Future<bool> addToBox<T>(String key, T? value);
  Future<Result<T?,Failure>> getFromBox<T>(String key);
}