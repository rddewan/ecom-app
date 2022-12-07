

import 'package:ecom_app/common/mixin/input_validation_mixin.dart';
import 'package:ecom_app/common/widget/form/custom_text_form_field.dart';
import 'package:ecom_app/features/auth/login/presentation/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPasswordWidget extends ConsumerWidget with InputValidationMixin{
 final TextEditingController passwordController;
 final String labelText;
 final String hintText;
 final String formKey;
 final List<String? Function(String?)> validators;

 LoginPasswordWidget({
    Key? key, 
    required this.passwordController,
    required this.labelText,
    required this.hintText,
    required this.formKey,
    required this.validators,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscure = ref.watch(
      loginControllerProvider.select((value) => value.isObscure),
    );

    return CustomTextFormField(
      labelText: labelText, 
      hintText: hintText,
      keyboardType: TextInputType.visiblePassword, 
      textInputAction: TextInputAction.next, 
      controller: passwordController,
      isObscureText: isObscure,
      prefixIcon: IconButton(
        onPressed: () {
          ref.read(loginControllerProvider.notifier).setIsObscure();          
        }, 
        icon: isObscure ? const Icon(Icons.visibility_off) : const Icon(Icons.visibility),
      ),
      suffixIcon: IconButton(
        onPressed: () {
          passwordController.clear();                    
        }, 
        icon: const Icon(Icons.clear),
      ),
      validator: combine(
        validators,
      ),
      onChanged: (String? value) {
        ref.read(
          loginControllerProvider.notifier,
        ).setFormData(key:formKey, value: value);

        return null;
      },
    );
  }
}