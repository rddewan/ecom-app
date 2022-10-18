


import 'package:ecom_app/core/firebase/analytics/firebase_analytics_provider.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final analyticsProvider = Provider<Analytics>((ref) {
  final firebaseAnalytics = ref.watch(firebaseAnalyticsProvider);

  return Analytics(firebaseAnalytics);

});

class Analytics {
  final FirebaseAnalytics _firebaseAnalytics;

  Analytics(this._firebaseAnalytics);

  Future<void> logAppOpen() async {
    await _firebaseAnalytics.logAppOpen();
  }

  Future<void> setCurrentScreen({required String screenName}) async {
    await _firebaseAnalytics.setCurrentScreen(screenName: screenName);
  }

  Future<void> logEvent(Map<String, Object?>? parameters,{required String name}) async{
    await _firebaseAnalytics.logEvent(name: name, parameters: parameters);
  }

  Future<void> setUserProperty({required String name,required String? value}) async {
    await _firebaseAnalytics.setUserProperty(name: name, value: value);
  }

  Future<void> resetAnalyticsData() async {
    await _firebaseAnalytics.resetAnalyticsData();
  }

  

  
}