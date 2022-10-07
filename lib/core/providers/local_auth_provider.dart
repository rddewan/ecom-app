
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';

final localAuthenticationAuthProvider = Provider<LocalAuthentication>((ref) {
  return LocalAuthentication();
});