

import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:ecom_app/core/route/notifier/go_router_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseConsumerState<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
            const Text('Login Screen'),
            ElevatedButton.icon(
              onPressed: () {
                ref.read(goRouterNotifierProvider).isLoggedIn = true;
              }, 
              icon: const Icon(Icons.login), 
              label: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}