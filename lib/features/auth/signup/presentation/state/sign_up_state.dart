
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'sign_up_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {

  const factory SignUpState({
    @Default(AsyncData(false))
    final AsyncValue<bool> isSignUp,
    @Default(false)
    final bool isLoading,
    @Default(true)
    final bool isObscure,
    @Default(false)
    final bool isTermsAndCondition,
    @Default({})
    final Map<String,dynamic> formData,
    final String? errorMsg,

  }) = _SignUpState;
}