

import 'package:flutter/material.dart';
import 'package:logging/logging.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {

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