
import 'package:ecom_app/base/base_state.dart';
import 'package:ecom_app/common/error/no_internet_connection_screen.dart';
import 'package:ecom_app/core/providers/internet_connection_observer.dart';
import 'package:ecom_app/i18n/i18n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainWidget extends ConsumerStatefulWidget {
  const MainWidget({super.key});

  @override
  ConsumerState<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends ConsumerState<MainWidget> {
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
      home: const HomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends BaseState<HomePage> {
  int _counter = 0;

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
      body: Center(
        
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
          ],
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
