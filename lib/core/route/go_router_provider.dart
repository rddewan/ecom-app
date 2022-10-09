
import 'package:ecom_app/common/error/no_internet_connection_screen.dart';
import 'package:ecom_app/common/error/no_route_screen.dart';
import 'package:ecom_app/core/route/notifier/go_router_notifier.dart';
import 'package:ecom_app/core/route/route_name.dart';
import 'package:ecom_app/features/auth/presentation/ui/login_screen.dart';
import 'package:ecom_app/features/auth/presentation/ui/signup_screen.dart';
import 'package:ecom_app/features/cart/presentation/ui/cart_screen.dart';
import 'package:ecom_app/features/dashboard/presentation/ui/dashboard_screen.dart';
import 'package:ecom_app/features/home/presentation/ui/home_screen.dart';
import 'package:ecom_app/features/setting/presentation/ui/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  bool isDuplicate = false;
  final notifier = ref.read(goRouterNotifierProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: (context, state) {

      final isLoggedIn = notifier.isLoggedIn;
      final isGoingToLogin = state.subloc == '/login';
      final isGoingToNoInternet = state.location == '/noInternet';
      
      if (!isLoggedIn && !isGoingToLogin && !isDuplicate && !isGoingToNoInternet) {

        isDuplicate = true;

        return '/login';
        
      }
      else if (isLoggedIn && isGoingToLogin && !isDuplicate) {
        isDuplicate = true;

        return '/';

      }

      if (isDuplicate) {
        isDuplicate = false;
      }

      return null;
      
    },
    routes: <RouteBase>  [

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/noInternet',
        name: noInternetRoute,
        builder: (context, state) => NoInternetConnectionScreen(key: state.pageKey),
      ),

      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/login',
        name: loginRoute,
        builder: (context, state) => LoginScreen(key: state.pageKey),
        routes: [

          GoRoute(
            path: 'signUp',
            name: signUpRoute,
            builder: (context, state) => SignUpScreen(key: state.pageKey),
          ),

        ],
      ),

      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return DashboardScreen(key: state.pageKey, child: child);
        },

        routes: [

          GoRoute(
            path: '/',
            name: homeRoute,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: HomeScreen(
                  key: state.pageKey,
                ),
              );
            },
          ),

          GoRoute(
            path: '/cart',
            name: cartRoute,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: CartScreen(
                  key: state.pageKey,
                ),
              );
            },
          ),

          GoRoute(
            path: '/setting',
            name: settingRoute,
            pageBuilder: (context, state) {
              return NoTransitionPage(
                key: state.pageKey,
                child: SettingScreen(
                  key: state.pageKey,
                ),
              );
            },
          ),
        ],
      ),

    ],
    errorBuilder: (context, state) => NoRouteScreen(
      key: state.pageKey,
    ),
  );
});