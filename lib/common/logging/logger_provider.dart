
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

final loggerProvider = Provider.family<Logger,String>((ref,name) {
  return Logger(name);
});