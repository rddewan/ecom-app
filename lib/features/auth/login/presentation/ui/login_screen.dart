

import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:ecom_app/core/route/notifier/go_router_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final String? from;
  const LoginScreen({this.from, Key? key}) : super(key: key);

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
                final location = widget.from;                
                ref.read(goRouterNotifierProvider).isLoggedIn = true;
                // deep link to app location
                if(location != null) GoRouter.of(context).go(location);
              }, 
              icon: const Icon(Icons.login), 
              label: const Text('Login'),
            ),

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
    );
  }
}