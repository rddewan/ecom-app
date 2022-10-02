import 'package:ecom_app/common/logging/logging_provider.dart';
import 'package:ecom_app/core/db/hive_db.dart';
import 'package:ecom_app/core/flavor/flavor.dart';
import 'package:ecom_app/core/providers/flavor_provider.dart';
import 'package:ecom_app/core/providers/internet_connection_observer.dart';
import 'package:ecom_app/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void mainApp(Flavor flavor) async {

  // An object that stores the state of the providers and allows overriding the behavior of a specific provider.
  final container = ProviderContainer();

  // Set the flavor state
  container.read(flavorProvider.notifier).state = flavor;
  
  // Setup Logger
  container.read(setupLoggingProvider);

  // setup the hive database
  container.read(hiveDbProvider);

  // Observer internet connection
  container.read(internetConnectionObserverProvider);

  
  runApp(
    // Expose a [ProviderContainer] to the widget tree.
    UncontrolledProviderScope(
      container: container, 
      child:  const MainWidget(),
    ),
  );
    
}
