

import 'package:ecom_app/core/exception/failure.dart';
import 'package:ecom_app/features/auth/login/presentation/controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginErrorWidget extends ConsumerWidget {
  const LoginErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final errorData = ref.watch(loginControllerProvider.select((value) => value.errorData));
    
    return errorData.when(
      data: (data) =>  const SizedBox.shrink(),
      error: (error, stackTrace) {
        final failure = error as Failure;
        return Center(
          child: Text(
            failure.message,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: Colors.redAccent,
            ),
          ),
        );        
      },
      loading: () => const SizedBox.shrink(),
    );
    
  }
}