
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:ecom_app/core/auth/local_auth.dart';
import 'package:ecom_app/core/firebase/crashlytics/crashlytics.dart';
import 'package:ecom_app/core/providers/app_background_state_provider.dart';
import 'package:ecom_app/core/providers/internet_connection_observer.dart';
import 'package:ecom_app/core/remote/network_service.dart';
import 'package:ecom_app/core/route/go_router_provider.dart';
import 'package:ecom_app/core/theme/app_theme.dart';
import 'package:ecom_app/core/theme/theme_const.dart';
import 'package:ecom_app/features/auth/login/presentation/controller/login_controller.dart';
import 'package:ecom_app/i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:upgrader/upgrader.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';


class MainWidget extends ConsumerStatefulWidget {
  const MainWidget({super.key});

  @override
  ConsumerState<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends BaseConsumerState<MainWidget> with  AppThemeMixin {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  

  @override
  void initState() {   
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(loginControllerProvider.notifier).getAccessToken();  
    });

    _setCrashlyticsUser();
    _isNetworkConnected();
    _networkConnectionObserver();
  }

  void _setCrashlyticsUser() async  {
    final crashlytics = ref.read(crashlyticsProvider);
     await  crashlytics.setUser('Richard');
  }


  void _isNetworkConnected() async {
    final isConnected = await ref.read(internetConnectionObserverProvider).isNetworkConnected();
    if (!isConnected) {
      if (!mounted) return;
      ref.read(goRouterProvider).push('/noInternet');      
    }
  }

  void _networkConnectionObserver() {
    final connectionStream = ref.read(internetConnectionObserverProvider).hasConnectionStream.stream;
    connectionStream.listen((isConnected) {
      if (!isConnected) {
        ref.read(goRouterProvider).push('/noInternet');      
      }
    });
  }

  // ignore: unused_element
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
    //final isAppInBackground = ref.watch(appBackgroundStateProvider);
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      scaffoldMessengerKey: scaffoldMessengerKey,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocales.supportedLocales,
      locale: AppLocales.en.locale,
      theme: FlexThemeData.light(
        colors: customFlexScheme.light,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 9,
        subThemesData: flexSubThemesDataLight,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ),
      darkTheme: FlexThemeData.dark(
        colors: customFlexScheme.dark,
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 15,
        subThemesData: flexSubThemesDataDark,
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
      ),
      themeMode: currentTheme(kLight),
      //home: isAppInBackground ? const ColoredBox(color: Colors.black) : const SettingScreen(),
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
