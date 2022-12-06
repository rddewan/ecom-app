

import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:ecom_app/common/extensions/string_hardcoded.dart';
import 'package:ecom_app/common/mixin/input_phone_formatter_mixin.dart';
import 'package:ecom_app/common/mixin/input_validation_mixin.dart';
import 'package:ecom_app/common/widget/app_scaffold.dart';
import 'package:ecom_app/common/widget/button/primary_button.dart';
import 'package:ecom_app/common/widget/checkbox/check_box_widget.dart';
import 'package:ecom_app/common/widget/form/custom_text_form_field.dart';
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

                },
              ),

              const SizedBox(height: 8,),

              CustomTextFormField(
                labelText: 'Password'.hardcoded, 
                hintText: 'Enter your password'.hardcoded,
                keyboardType: TextInputType.visiblePassword, 
                textInputAction: TextInputAction.next, 
                controller: _passwordController,
                isObscureText: true,
                prefixIcon: const Icon(Icons.visibility_off),
                suffixIcon: IconButton(
                  onPressed: () {
                    _passwordController.clear();                    
                  }, 
                  icon: const Icon(Icons.clear),
                ),
                validator: combine(
                  [
                    withMessage(
                      'password is empty'.hardcoded, 
                      isTextEmpty,
                    ),
                    withMessage(
                      'password is invalid'.hardcoded, 
                      isPasswordInvalid,
                    )
                  ]
                ),
                onChanged: (String? value) {

                },
              ),

              const SizedBox(height: 8,),

              CustomTextFormField(
                labelText: 'Confirm Password'.hardcoded, 
                hintText: 'Enter your confirm password'.hardcoded,
                keyboardType: TextInputType.visiblePassword, 
                textInputAction: TextInputAction.next, 
                controller: _confirmPasswordController,
                isObscureText: true,
                prefixIcon: const Icon(Icons.visibility_off),
                suffixIcon: IconButton(
                  onPressed: () {
                    _confirmPasswordController.clear();                    
                  }, 
                  icon: const Icon(Icons.clear),
                ),
                validator: combine(
                  [
                    withMessage(
                      'password is empty'.hardcoded, 
                      isTextEmpty,
                    ),
                    withMessage(
                      'password is invalid'.hardcoded, 
                      isPasswordInvalid,
                    )
                  ]
                ),
                onChanged: (String? value) {

                },
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

                },
              ),

              const SizedBox(height: 8,),

              CheckboxWidget(
                title: 'Terms and conditions', 
                subtitle: 'Please accept the terms and conditions', 
                value: false, 
                validator: (value) {
                  return isValidTermsAndConditions(
                    value, 
                    'Please accept the terms and conditions',
                  );
                },
                onChanged: (value) {

                },
              ),

              const SizedBox(height: 8,),

              PrimaryButton(
                text: 'SignUp',
                isEnabled: true,
                isLoading: false,
                onPressed: () {

                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}