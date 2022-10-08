
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:ecom_app/common/error/no_internet_connection_screen.dart';
import 'package:ecom_app/core/auth/local_auth.dart';
import 'package:ecom_app/core/providers/app_background_state_provider.dart';
import 'package:ecom_app/core/providers/internet_connection_observer.dart';
import 'package:ecom_app/core/remote/network_service.dart';
import 'package:ecom_app/features/setting/presentation/ui/setting_screen.dart';
import 'package:ecom_app/i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgrader/upgrader.dart';

class MainWidget extends ConsumerStatefulWidget {
  const MainWidget({super.key});

  @override
  ConsumerState<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends BaseConsumerState<MainWidget> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  void initState() {   
    super.initState();
    _isNetworkConnected();
    _networkConnectionObserver();
  }


  void _isNetworkConnected() async {
    final isConnected = await ref.read(internetConnectionObserverProvider).isNetworkConnected();
    if (!isConnected) {
      if (!mounted) return;
      navigatorKey.currentState?.push(MaterialPageRoute(builder: (_) => const NoInternetConnectionScreen()));
    }
  }

  void _networkConnectionObserver() {
    final connectionStream = ref.read(internetConnectionObserverProvider).hasConnectionStream.stream;
    connectionStream.listen((isConnected) {
      if (!isConnected) {
        _showSnackBar();        
      }
    });
  }

  void _showSnackBar() {
    scaffoldMessengerKey.currentState?.clearSnackBars();
    scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text(
          "No internet connection",
        ),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isAppInBackground = ref.watch(appBackgroundStateProvider);

    return MaterialApp(
      title: 'Flutter Demo',
      navigatorKey: navigatorKey,
      scaffoldMessengerKey: scaffoldMessengerKey,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocales.supportedLocales,
      locale: AppLocales.en.locale,
      theme: ThemeData(      
        primarySwatch: Colors.blue,
      ),
      home: isAppInBackground ? const ColoredBox(color: Colors.black) : const SettingScreen(),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {    
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        ref.read(appBackgroundStateProvider.notifier).state = true;        
        break;
      case AppLifecycleState.resumed:
        ref.read(appBackgroundStateProvider.notifier).state = false;        
        break;
      default:
    }
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseConsumerState<HomePage> {
  int _counter = 0;
  late Dio _dio;

  @override
  void initState() {    
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _dio = ref.read(networkServiceProvider);
      getSomeData();
      
    });
  }

  void getSomeData() async {
    final response = await _dio.get('api/v1/banner/getHomeBannerSlider');
    log.info(response);

  }

  void _incrementCounter() {
    setState(() {
    
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        
        title: Text(widget.title),
      ),
      body: UpgradeAlert(
        upgrader: Upgrader(
          shouldPopScope: () => true,
          canDismissDialog: true,
          durationUntilAlertAgain: const Duration(days: 1),
          dialogStyle: Platform.isIOS ? UpgradeDialogStyle.cupertino : UpgradeDialogStyle.material,
        ),
        child: Center(
          
          child: Column(
          
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                translation.buttonPushMsg(_counter),
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
              ),

              ElevatedButton(
                onPressed: () async {
                  final didAuthenticate = await ref.read(localAuthProvider).authenticate();
                  if (didAuthenticate) {
                    debugPrint('successful auth');
                  }

                }, 
                child: const Text('Authenticate To Unlock'),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: translation.increment,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
