
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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    refreshListenable: ref.read(goRouterNotifierProvider),
    routes: <RouteBase>  [

      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: '/noInternet',
        name: noInternetRoute,
        builder: (context, state) => NoInternetConnectionScreen(key: state.pageKey),
      ),

      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: '/login',
        name: loginRoute,
        builder: (context, state) => LoginScreen(key: state.pageKey),
        routes: [

          GoRoute(
            parentNavigatorKey: navigatorKey,
            path: '/signUp',
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