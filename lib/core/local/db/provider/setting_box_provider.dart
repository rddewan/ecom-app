

import 'package:ecom_app/core/local/db/hive_box_key.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

final settingBoxProvider = Provider<Box>((ref) {
  return Hive.box(settingBox);
});