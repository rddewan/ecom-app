
import 'package:ecom_app/common/extensions/string_hardcoded.dart';
import 'package:ecom_app/common/widget/button/primary_button.dart';
import 'package:ecom_app/features/auth/login/presentation/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginButtonWidget extends ConsumerWidget {
  final VoidCallback onPressed;
  const LoginButtonWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ref.watch(loginControllerProvider.select((value) => value.isLoading));
    return PrimaryButton(
      text: 'LogIn'.hardcoded,
      isEnabled: isLoading ? false : true,
      isLoading: isLoading,
      onPressed: onPressed,
    );
  }
}