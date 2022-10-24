

import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final firebasePerformanceProvider = Provider<FirebasePerformance>((ref) {
  return FirebasePerformance.instance;
});