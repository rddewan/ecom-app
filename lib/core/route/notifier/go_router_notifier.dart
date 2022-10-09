

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final goRouterNotifierProvider = Provider<GoRouterNotifier>((ref) {
  return GoRouterNotifier();
});

class GoRouterNotifier extends ChangeNotifier {

}