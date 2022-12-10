
import 'package:ecom_app/core/route/notifier/go_router_notifier.dart';
import 'package:ecom_app/features/auth/login/application/login_service.dart';
import 'package:ecom_app/features/auth/login/presentation/state/login_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  
  @override
  LoginState build() {
    return const LoginState();
  }

  void login() async {
    final loginService = ref.read(loginServiceProvider);
    state = state.copyWith(isLoading: true, errorData: const AsyncValue.data(''), errorMsg: null);

    final result = await loginService.login(state.formData);

    result.when(
      (success) {

        state = state.copyWith(
          isLoading: false,
          isLoggedIn: const AsyncValue.data(true),
        );
        ref.read(goRouterNotifierProvider).isLoggedIn = true;

      }, 
      (error) {
        state = state.copyWith(
          isLoading: false,
          errorData: AsyncValue.error(
            error, 
            error.stackTrace ?? StackTrace.fromString('stackTraceString'),
          ),
          errorMsg: error.message,
        );

      },
    );
    
  }

  void setIsObscure() {
    state = state.copyWith(isObscure: !state.isObscure);
  }

  void setFormData({required String key, required dynamic value}) {
    state = state.copyWith(formData: {...state.formData, ...{key:value}});
  }
}