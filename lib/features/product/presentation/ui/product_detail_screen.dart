

import 'dart:io';

import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailScreen extends ConsumerStatefulWidget {
  const ProductDetailScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends BaseConsumerState<ProductDetailScreen> {
  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Product Detail'),
          centerTitle: true,
          leading: BackButton(
            onPressed: () {
              context.pop();          
            },
            
          ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
              const Text('Product Screen'),
              const SizedBox(height: 8,),
              ElevatedButton.icon(
                onPressed: () => throw Exception('Crash Testing from Flutter App: ${Platform.isAndroid ? 'Android' : 'iOS'}'), 
                icon: const Icon(Icons.error_rounded), 
                label: const Text('Record Exception'),
              ),
              ElevatedButton.icon(
                onPressed: () {
    
                  showDialog(
                    context: context, 
                    barrierDismissible: true,
                    builder: (context) {
                      return WillPopScope(
                        onWillPop: () async => true,
                        child: AlertDialog(
                          content: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.info),
                                const SizedBox(height: 8,),
                                const Text('Qty of product 10'),
                                const SizedBox(height: 8,),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    final navigator = Navigator.of(context,rootNavigator: true);
                                    if (navigator.canPop()) {
                                      navigator.pop();
                                    }
    
                                  }, 
                                  icon: const Icon(Icons.close), 
                                  label: const Text('Ok'),
                                )
                                
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
    
                }, 
                icon: const Icon(Icons.inventory), 
                label: const Text('Stock Detail'),
              )
            ],
          ),
        ),
      ),
    );
  }
}