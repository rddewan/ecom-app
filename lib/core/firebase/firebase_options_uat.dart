// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_uat.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class UatFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCj0PJ3VmIXHF0rPG0WfJDbvkJ1z3xsDiQ',
    appId: '1:459430567158:android:7f825e01e4e3da1b38e0d7',
    messagingSenderId: '459430567158',
    projectId: 'flutter-ecomapp-uat-e3721',
    storageBucket: 'flutter-ecomapp-uat-e3721.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyASdBKd6zFbB3pO4N2GpShHAsEbUoKLGII',
    appId: '1:459430567158:ios:399f81d946541e5638e0d7',
    messagingSenderId: '459430567158',
    projectId: 'flutter-ecomapp-uat-e3721',
    storageBucket: 'flutter-ecomapp-uat-e3721.appspot.com',
    iosClientId: '459430567158-n2b5gokofdie3jl3i22jimt7s64cr1qm.apps.googleusercontent.com',
    iosBundleId: 'dev.rdewan.ecomApp.uat',
  );
}
