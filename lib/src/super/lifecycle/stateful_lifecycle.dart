import 'dart:ui';

import 'package:flutter/material.dart';

import 'state_lifecycle.dart';

/// @author : ch
/// @date 2024-03-14 16:40:19
/// @description StatefulWidget 的生命周期实现基于原生实现
///
final RouteObserver routeObserver = RouteObserver();

mixin StatefulLifecycle<T extends StatefulWidget> on State<T> implements RouteAware, WidgetsBindingObserver, StateLifecycle {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route != null && route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didPop() {
    onStop();
  }

  @override
  void didPopNext() {
    onResume();
  }

  @override
  void didPush() {
    onStart();
  }

  @override
  void didPushNext() {
    onPause();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      onResume();
    } else if (state == AppLifecycleState.paused) {
      onPause();
    }
  }

  //  =========================== 默认空实现 ===========================

  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeLocales(List<Locale>? locales) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {}

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() {
    return Future<bool>.value(false);
  }

  @override
  Future<bool> didPushRoute(String route) {
    return Future<bool>.value(false);
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    return didPushRoute(routeInformation.location!);
  }

  @override
  Future<AppExitResponse> didRequestAppExit() async {
    return AppExitResponse.exit;
  }

  @override
  void onStart() {}

  @override
  void onStop() {}

  @override
  void onResume() {}

  @override
  void onPause() {}
}
