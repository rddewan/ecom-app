


import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logging/logging.dart';

abstract class BaseConsumerState<T extends ConsumerStatefulWidget> extends ConsumerState<T> {

  Logger get log => Logger(T.toString());

  @override
  void initState() {   
    log.info("$T initState");
    super.initState();
  }

  @override
  void dispose() {  
    log.info("$T dispose");  
    super.dispose();
  }
}