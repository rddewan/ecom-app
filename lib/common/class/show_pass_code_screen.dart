

import 'package:flutter/material.dart';
import 'package:flutter_screen_lock/flutter_screen_lock.dart';

abstract class ShowPassCodeScreen {

  void showPassCode(
    BuildContext context, {      
      required String correctString,
      required void Function() didUnlocked,
      Widget title = const Text('Enter your PassCode'),
      bool useLandscape = false,
      int retryDelay = 60,      
      Widget Function(BuildContext, Duration)? delayBuilder,      
    }

  ) {

    screenLock(
      context: context, 
      correctString: correctString,
      title: title,      
      digits: 6,
      useLandscape: useLandscape,      
      retryDelay: Duration(seconds: retryDelay),
      maxRetries: 3,
      delayBuilder: delayBuilder ?? (context, delay) => Text(
        'Cannot be entered for ${(delay.inMilliseconds / 1000).ceil()} Second.',
      ),
      didUnlocked: didUnlocked,

    );
  }

}