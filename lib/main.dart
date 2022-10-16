import 'dart:async';

import 'package:ecom_app/common/logging/logging_provider.dart';
import 'package:ecom_app/core/firebase/crashlytics/crashlytics.dart';
import 'package:ecom_app/core/firebase/firebase_options_provider.dart';
import 'package:ecom_app/core/local/db/hive_db.dart';
import 'package:ecom_app/core/flavor/flavor.dart';
import 'package:ecom_app/core/providers/flavor_provider.dart';
import 'package:ecom_app/core/providers/internet_connection_observer.dart';
import 'package:ecom_app/core/security/securoty_config.dart';
import 'package:ecom_app/main_widget.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

void mainApp(Flavor flavor) async {

  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    // An object that stores the state of the providers and allows overriding the behavior of a specific provider.
    final container = ProviderContainer();

    // Set the flavor state
    container.read(flavorProvider.notifier).state = flavor;

    final firebaseOptions = container.read(firebaseOptionsProvider(flavor));
    // Initializes a new [FirebaseApp] instance by [name] and [options] 
    // and returns the created app. This method should be called before any usage of FlutterFire plugins.
    await Firebase.initializeApp(
      options: firebaseOptions,
    );

    // Pass all uncaught errors from the framework to Crashlytics.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    // Enables/disables automatic data collection by Crashlytics.
    container.read(crashlyticsProvider);

    // Setup Logger
    container.read(setupLoggingProvider);

    // setup the hive database
    final db = container.read(hiveDbProvider);
    await db.init();

    // Observer internet connection
    container.read(internetConnectionObserverProvider);

    // Security config
    container.read(securityConfigProvider);

    
    runApp(
      // Expose a [ProviderContainer] to the widget tree.
      UncontrolledProviderScope(
        container: container, 
        child:  const MainWidget(),
      ),
    );

    
  }, (error, stack) =>
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true),);
    
}
