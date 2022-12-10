

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(AsyncValue.data(false))
    final AsyncValue<bool> isLoggedIn,
    @Default(false)
    final bool isLoading,
    @Default(true)
    final bool isObscure,
    @Default({})
    final Map<String, dynamic> formData,
    @Default(AsyncValue.data(''))
    final AsyncValue<String> errorData,
    final String? errorMsg,

  }) = _LoginState;


}