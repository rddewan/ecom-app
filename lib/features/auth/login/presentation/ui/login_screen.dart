

import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:ecom_app/common/extensions/string_hardcoded.dart';
import 'package:ecom_app/common/mixin/input_validation_mixin.dart';
import 'package:ecom_app/common/widget/app_scaffold.dart';
import 'package:ecom_app/common/widget/form/custom_text_form_field.dart';
import 'package:ecom_app/features/auth/login/presentation/controller/login_controller.dart';
import 'package:ecom_app/features/auth/login/presentation/ui/widget/login_button_widget.dart';
import 'package:ecom_app/features/auth/login/presentation/ui/widget/login_error_widget.dart';
import 'package:ecom_app/features/auth/login/presentation/ui/widget/login_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String? from;
  const LoginScreen({this.from, Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseConsumerState<LoginScreen> with InputValidationMixin{

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title:  const Text('Login'), 
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16,),

              const LoginErrorWidget(),

              const SizedBox(height: 16,),

              CustomTextFormField(
                labelText: 'Email'.hardcoded, 
                hintText: 'Enter your email'.hardcoded,
                keyboardType: TextInputType.emailAddress, 
                textInputAction: TextInputAction.next, 
                controller: _emailController,
                prefixIcon: const Icon(Icons.email),
                suffixIcon: IconButton(
                  onPressed: () {
                    _emailController.clear();                    
                  }, 
                  icon: const Icon(Icons.clear),
                ),
                validator: combine(
                  [
                    withMessage(
                      'email is empty'.hardcoded, 
                      isTextEmpty,
                    ),
                    withMessage(
                      'email is invalid'.hardcoded, 
                      isInvalidEmail,
                    )
                  ]
                ),
                onChanged: (String? value) {
                  ref.read(
                    loginControllerProvider.notifier,
                  ).setFormData(key:'email', value: value);

                  return null;
                },
              ),

              const SizedBox(height: 8,),

              LoginPasswordWidget(
                passwordController: _passwordController,
                labelText: 'Password'.hardcoded,
                hintText: 'Please enter your password'.hardcoded,
                formKey: 'password'.hardcoded,
                validators: [
                  withMessage('password is empty', isTextEmpty),
                  withMessage('invalid password', isPasswordInvalid)
                ],
              ),

              const SizedBox(height: 16,),

              LoginButtonWidget(onPressed: _login),

              const SizedBox(height: 16,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  const SizedBox(width: 8,),
                  GestureDetector(
                    onTap: () => GoRouter.of(context).push('/login/signUp'),
                    child: const Text("Register Now!"),
                  ),
                ],
              )

            ],

          ),
        ),
      ),
      
    );   
    
  }

  void _login() {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      ref.read(loginControllerProvider.notifier).login();
    }
  }
}