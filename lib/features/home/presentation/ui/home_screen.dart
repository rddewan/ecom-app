

import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home Screen'),
            const SizedBox(height: 8,),
            ElevatedButton.icon(
              onPressed: () {
                context.go('/detail');
              }, 
              icon: const Icon(Icons.inventory), 
              label: const Text('Product Detail'),
            )
          ],
        ),
      ),
    );
  }
}