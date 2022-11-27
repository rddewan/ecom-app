
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
      showUnselectedLabels: true,      
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