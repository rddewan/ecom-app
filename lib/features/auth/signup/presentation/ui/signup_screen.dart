

import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:ecom_app/common/extensions/string_hardcoded.dart';
import 'package:ecom_app/common/mixin/input_phone_formatter_mixin.dart';
import 'package:ecom_app/common/mixin/input_validation_mixin.dart';
import 'package:ecom_app/common/widget/app_scaffold.dart';
import 'package:ecom_app/common/widget/button/primary_button.dart';
import 'package:ecom_app/common/widget/form/custom_text_form_field.dart';
import 'package:ecom_app/features/auth/signup/presentation/controller/sign_up_controller.dart';
import 'package:ecom_app/features/auth/signup/presentation/ui/widget/signup_password_widget.dart';
import 'package:ecom_app/features/auth/signup/presentation/ui/widget/terms_conditions_checkbox_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends BaseConsumerState<SignUpScreen>  
  with InputValidationMixin, InputPhoneFormatter {

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();


  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: const Text("SignUp"), 
      widget: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 16,),

              CustomTextFormField(
                labelText: 'Name'.hardcoded, 
                hintText: 'Enter your name'.hardcoded,
                keyboardType: TextInputType.text, 
                textInputAction: TextInputAction.next, 
                controller: _nameController,
                prefixIcon: const Icon(Icons.person),
                suffixIcon: IconButton(
                  onPressed: () {
                    _nameController.clear();                    
                  }, 
                  icon: const Icon(Icons.clear),
                ),
                validator: combine(
                  [
                    withMessage(
                      'name is empty'.hardcoded, 
                      isTextEmpty,
                    )
                  ]
                ),
                onChanged: (String? value) {
                  ref.read(
                    signUpControllerProvider.notifier,
                  ).setFormData(key:'name', value: value);

                  return null;
                },
              ),

              const SizedBox(height: 8,),

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
                    signUpControllerProvider.notifier,
                  ).setFormData(key:'email', value: value);

                  return null;
                },
              ),

              const SizedBox(height: 8,),

              SignUpPasswordWidget(
                passwordController: _passwordController,
                labelText: 'Password'.hardcoded,
                hintText: 'Please enter your password'.hardcoded,
                formKey: 'password'.hardcoded,
                validators: [
                  withMessage('password is empty', isTextEmpty),
                  withMessage('invalid password', isPasswordInvalid)
                ],
              ),

              const SizedBox(height: 8,),

              SignUpPasswordWidget(
                passwordController: _confirmPasswordController,
                labelText: 'Confirm Password'.hardcoded,
                hintText: 'Enter your confirm password'.hardcoded,
                formKey: 'password_confirmation'.hardcoded,
                validators: [
                  withMessage('password is empty', isTextEmpty),
                  withMessage('invalid password', isPasswordInvalid),
                  withMessage(
                    'Password and confirm password does not match', 
                    (String? confirmPassword) {
                      final password = _passwordController.text;
                      if(confirmPassword != password) {
                        return ValidateFailResult.passwordNotMatch;
                      }
                      return null;
                    },
                  )
                ],
              ),
              
              const SizedBox(height: 8,),

              CustomTextFormField(
                labelText: 'Phone'.hardcoded, 
                hintText: 'Enter your phone'.hardcoded,
                keyboardType: TextInputType.phone, 
                textInputAction: TextInputAction.next, 
                controller: _phoneController,               
                prefixIcon: const Icon(Icons.phone),
                suffixIcon: IconButton(
                  onPressed: () {
                    _phoneController.clear();                    
                  }, 
                  icon: const Icon(Icons.clear),
                ),
                inputFormatters: [
                  maskPhoneFormatter
                ],
                validator: combine(
                  [
                    withMessage(
                      'phone is empty'.hardcoded, 
                      isTextEmpty,
                    ),
                    withMessage(
                      'phone is invalid'.hardcoded, 
                      isInvalidPhoneNumber,
                    )
                  ]
                ),
                onChanged: (String? value) {
                  ref.read(
                    signUpControllerProvider.notifier,
                  ).setFormData(
                    key:'phone', 
                    value: value?.replaceAll(RegExp(r'-'), ''),
                  );

                  return null;
                },
              ),

              const SizedBox(height: 8,),

              TermsConditionsCheckboxWidget(),

              const SizedBox(height: 8,),

              PrimaryButton(
                text: 'SignUp',
                isEnabled: true,
                isLoading: false,
                onPressed: () {
                  _signUp();                 
                },
              ),

            ],
          ),
        ),
      ),
    );
  }

  void _signUp() {
    final isValid = _formKey.currentState?.validate();

    if (isValid != null && isValid) {
      ref.read(signUpControllerProvider.notifier).signUp();
    }
  }

}