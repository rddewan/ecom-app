
import 'package:ecom_app/core/firebase/firebase_options_dev.dart';
import 'package:ecom_app/core/firebase/firebase_options_prod.dart';
import 'package:ecom_app/core/firebase/firebase_options_qa.dart';
import 'package:ecom_app/core/firebase/firebase_options_uat.dart';
import 'package:ecom_app/core/flavor/flavor.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebaseOptionsProvider = Provider.family<FirebaseOptions,Flavor>((ref,flavor) {
  switch (flavor) {
    case Flavor.dev:
      return DevFirebaseOptions.currentPlatform;  
    case Flavor.qa:
      return QaFirebaseOptions.currentPlatform; 
    case Flavor.uat:
      return UatFirebaseOptions.currentPlatform; 
    case Flavor.prod:
      return ProdFirebaseOptions.currentPlatform;    
    default:
    return DevFirebaseOptions.currentPlatform;  
  }
});