
import 'package:ecom_app/features/auth/signup/application/sign_up_service.dart';
import 'package:ecom_app/features/auth/signup/presentation/state/sign_up_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final signUpControllerProvider= NotifierProvider<SignUpController,SignUpState>(SignUpController.new);

class SignUpController extends Notifier<SignUpState> {
  @override
  SignUpState build() {
    return const SignUpState();
  }

  void signUp() async {
    final signUpService = ref.read(signUpServiceProvider);

    state = state.copyWith(isLoading: true);
    final result = await signUpService.signUp(state.formData);
    if(result.id > 0) {
      state = state.copyWith(
        isLoading: false,
        isSignUp: const AsyncValue.data(true),
      );
    }
  }

  void setTermsAndCondition(bool value) {
    state = state.copyWith(isTermsAndCondition: value);
  }

  void setIsObscure() {
    state = state.copyWith(isObscure: !state.isObscure);
  }

  void setFormData({required String key, required dynamic value}) {
    state = state.copyWith(
      formData: {...state.formData, ...{key:value}},
    );
  }
  
}