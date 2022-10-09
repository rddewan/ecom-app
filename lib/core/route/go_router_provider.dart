
import 'package:ecom_app/common/error/no_route_screen.dart';
import 'package:ecom_app/core/route/route_name.dart';
import 'package:ecom_app/features/setting/presentation/ui/setting_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/setting',
    routes: <RouteBase>  [

      GoRoute(
        path: '/setting',
        name: settingRoute,
        builder: (context, state) => SettingScreen(key: state.pageKey),
      ),

    ],
    errorBuilder: (context, state) => NoRouteScreen(
      key: state.pageKey,
    ),
  );
});