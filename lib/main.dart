import 'package:ecom_app/common/logging/logging_provider.dart';
import 'package:ecom_app/core/firebase/firebase_options_provider.dart';
import 'package:ecom_app/core/local/db/hive_db.dart';
import 'package:ecom_app/core/flavor/flavor.dart';
import 'package:ecom_app/core/providers/flavor_provider.dart';
import 'package:ecom_app/core/providers/internet_connection_observer.dart';
import 'package:ecom_app/core/security/securoty_config.dart';
import 'package:ecom_app/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

void mainApp(Flavor flavor) async {

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
    
}
