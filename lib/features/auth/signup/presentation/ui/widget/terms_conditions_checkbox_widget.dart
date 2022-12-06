
import 'package:ecom_app/common/mixin/input_validation_mixin.dart';
import 'package:ecom_app/common/widget/checkbox/check_box_widget.dart';
import 'package:ecom_app/features/auth/signup/presentation/controller/sign_up_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TermsConditionsCheckboxWidget extends ConsumerWidget with InputValidationMixin {
  TermsConditionsCheckboxWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isChecked = ref.watch(
      signUpControllerProvider.select((value) => value.isTermsAndCondition),
    );

    return CheckboxWidget(
      title: 'Terms and conditions', 
      subtitle: 'Please accept the terms and conditions', 
      value: isChecked, 
      validator: (value) {
        return isValidTermsAndConditions(
          value, 
          'Please accept the terms and conditions',
        );
      },
      onChanged: (value) {
        ref.read(
          signUpControllerProvider.notifier,
        ).setTermsAndCondition(value ?? false);

      },
    );
  }
}