
import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:ecom_app/core/providers/internet_connection_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NoInternetConnectionScreen extends ConsumerStatefulWidget {
  const NoInternetConnectionScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<NoInternetConnectionScreen> createState() => _NoInternetConnectionScreenState();
}

class _NoInternetConnectionScreenState extends BaseConsumerState<NoInternetConnectionScreen> {

  @override
  void initState() {   
    super.initState();
    _networkConnectionObserver();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("No Internet"),),
      body: Center(
        child: Column(
          children: [
            const Text('Please check your internet connection'),
            ElevatedButton.icon(
              onPressed: () {
                _isNetworkConnected();
              }, 
              icon: const Icon(Icons.refresh), 
              label: const Text('Refresh'),
            )
          ],
        ),
      ),
    );
  }

  void _isNetworkConnected() async {
    final isConnected = await ref.read(internetConnectionObserverProvider).isNetworkConnected();
    if (isConnected) {
      if (!mounted) return;
      context.pop();
      
    }
  }

  void _networkConnectionObserver() {
    final connectionStream = ref.read(internetConnectionObserverProvider).hasConnectionStream.stream;
    connectionStream.listen((isConnected) {
      if (isConnected) {
        if (!mounted) return;
        context.pop();
      }
    });
  }
}