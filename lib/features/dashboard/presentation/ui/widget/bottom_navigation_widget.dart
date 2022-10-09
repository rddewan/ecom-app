
import 'dart:ui';

import 'package:ecom_app/base/base_consumer_state.dart';
import 'package:ecom_app/features/dashboard/presentation/controller/dashboard_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  const BottomNavigationWidget({Key? key}) : super(key: key);

  @override
  ConsumerState<BottomNavigationWidget> createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends BaseConsumerState<BottomNavigationWidget> {
  @override
  Widget build(BuildContext context) {
    final index = ref.watch(dashboardControllerProvider.select((value) => value.pageIndex));

    return BottomNavigationBar(
      currentIndex: index,
      onTap: (value) => _onItemTapped(value),
      selectedItemColor: Colors.green,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: true,
      selectedLabelStyle: const TextStyle(
        color: Colors.green,
        fontSize: 14,
        fontWeight: FontWeight.w700,
      ),
      unselectedLabelStyle: const TextStyle(
        color: Colors.grey,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      items: const [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home),
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.shopify),
          icon: Icon(Icons.shopping_bag),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.settings),
          icon: Icon(Icons.settings_applications),
          label: 'Setting',
        ),

      ],
    );
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final GoRouter route = GoRouter.of(context);
    final String location = route.location;
    
    if (location.startsWith('/')) {
      return 0;
    }
    if (location.startsWith('/cart')) {
      return 1;
    }
    if (location.startsWith('/setting')) {
      return 2;
    }

    return 0;

  }

  void _onItemTapped(int index) {
    ref.read(dashboardControllerProvider.notifier).setPageIndex(index);

    switch (index) {
      case 0:
        GoRouter.of(context).go('/');
        break;
      case 1:
        GoRouter.of(context).go('/cart');
        break;
      case 2:
        GoRouter.of(context).go('/setting');
        break;
      default:
    }

  }
}