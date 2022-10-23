
import 'package:ecom_app/core/firebase/crashlytics/firebase_crashlytics_provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final crashlyticsProvider = Provider<Crashlytics>((ref) {
  final crashlytics = ref.watch(firebaseCrashlyticsProvider);

  return Crashlytics(crashlytics);

});

class Crashlytics {
  final FirebaseCrashlytics _crashlytics;

  Crashlytics(this._crashlytics) {
    _init();
  }

  /// Enables/disables automatic data collection by Crashlytics.
  void _init() async {
    if (kDebugMode) {
      await _crashlytics.setCrashlyticsCollectionEnabled(true);
    }
    else {
      await _crashlytics.setCrashlyticsCollectionEnabled(true);
    }
  }

  /// Records a user ID (identifier) that's associated with subsequent fatal and non-fatal reports.
  Future<void> setUser(String user) async {
    await _crashlytics.setUserIdentifier(user);
  }

  Future<void> nonFatalCrash({required dynamic exception, StackTrace? stack, String? reason})  async {
    if (_crashlytics.isCrashlyticsCollectionEnabled) {
      await _crashlytics.recordError(
        exception, 
        stack,
        reason: reason ?? 'Non_fatal Error',
      );
    }
  }
  
}