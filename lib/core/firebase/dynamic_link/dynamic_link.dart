

import 'package:ecom_app/core/firebase/crashlytics/crashlytics.dart';
import 'package:ecom_app/core/route/go_router_provider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dynamicLinkProvider = Provider<DynamicLink>((ref) {
  final crashlytics = ref.watch(crashlyticsProvider);

  return DynamicLink(ref, crashlytics);

});

class DynamicLink {
  final Ref _ref;
  final Crashlytics _crashlytics;

  DynamicLink(this._ref, this._crashlytics) {
    _init();
  }

  void _init() async {
    //Terminated State
    // If the application is terminated, the FirebaseDynamicLinks.getInitialLink method 
    //allows you to retrieve the Dynamic Link that opened the application.
    // Get any initial links
    final PendingDynamicLinkData? initialLink = await FirebaseDynamicLinks.instance.getInitialLink();
    if(initialLink != null) {
      _ref.read(goRouterProvider).go(initialLink.link.path);
    }

    //Background / Foreground State
    //Whilst the application is open, or in the background, you may listen to 
    //Dynamic Links events using a stream handler. 
    //The FirebaseDynamicLinks.onLink getter returns a Stream containing a PendingDynamicLinkData:
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {    
      _ref.read(goRouterProvider).go(dynamicLinkData.link.path);
    }).onError((error) {
      _crashlytics.nonFatalCrash(exception: error);
    });



  }
}