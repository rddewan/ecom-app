

import 'dart:io';

import 'package:ecom_app/core/env/env_reader.dart';
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

    // ignore: unused_element
    Future<ShortDynamicLink> buildShortDynamicLink(
      String link,
      String uriPrefix,
      String fallBackUrl,
      String campaignName,
      String? tagTitle,
      String? tagDescription,
    ) async {

      final dynamicLinkParams = DynamicLinkParameters(
        link: Uri.parse(link), 
        uriPrefix: uriPrefix,
        androidParameters: AndroidParameters(
          packageName: _ref.read(envReaderProvider).getAndroidBuildId(),
          fallbackUrl:  Uri.parse(fallBackUrl),
        ),
        iosParameters: IOSParameters(
          bundleId: _ref.read(envReaderProvider).getIosBuildId(),
          fallbackUrl: Uri.parse(fallBackUrl),
        ),
        googleAnalyticsParameters: GoogleAnalyticsParameters(
          source: _getSource(),
          medium: 'APP',
          campaign: campaignName,
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
          title: tagTitle,
          description: tagDescription,
        ),
      );

      final shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
        dynamicLinkParams,
        shortLinkType: ShortDynamicLinkType.unguessable,
      );

      return shortDynamicLink;

    }


  }

  String _getSource() {
    if (Platform.isAndroid) {
      return 'android';
    }
    else if(Platform.isIOS) {
      return 'iOS';
    }
    else {
      return 'non';
    }
  }
}