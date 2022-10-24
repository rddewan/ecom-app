

import 'package:ecom_app/core/firebase/performance/firebase_performance_provider.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final performanceProvider = Provider<Performance>((ref) {
  final firebasePerformance = ref.watch(firebasePerformanceProvider);

  return Performance(firebasePerformance);

});

class Performance {

  final FirebasePerformance _firebasePerformance;

  Performance(this._firebasePerformance) {
    _init();
  }
  

  void _init() {
    if (kDebugMode) {
      // Enables or disables custom performance monitoring setup.
      _firebasePerformance.setPerformanceCollectionEnabled(true);
    }
    else {
      _firebasePerformance.setPerformanceCollectionEnabled(true);
    }

  }

  Trace getTrace(String name) {
    return _firebasePerformance.newTrace(name);
  }


}