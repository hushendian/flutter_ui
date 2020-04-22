import 'package:flutter/material.dart';

class ToastNavigatorObserverProxy {
  void Function(Route<dynamic> route, Route<dynamic> previousRoute) didPush;
  void Function(Route<dynamic> newRoute, Route<dynamic> oldRoute) didReplace;
  void Function(Route<dynamic> route, Route<dynamic> previousRoute) didRemove;
  void Function(Route<dynamic> route, Route<dynamic> previousRoute) didPop;

  ToastNavigatorObserverProxy(
      {this.didPush, this.didReplace, this.didRemove, this.didPop});

  ToastNavigatorObserverProxy.all(VoidCallback leavePageCallback) {
    didPush = (_, __) => leavePageCallback();
    didReplace = (_, __) => leavePageCallback();
    didRemove = (_, __) => leavePageCallback();
    didPop = (_, __) => leavePageCallback();
  }
}

///如果你项目有多个[Navigator],请将该ToastNavigatorObserver添加到[Navigator.observers]
class ToastNavigatorObserver extends NavigatorObserver {
  static final List<ToastNavigatorObserverProxy> _leavePageCallbacks = [];

  static bool debugInitialization = false;

  ToastNavigatorObserver() {
    assert(() {
      debugInitialization = true;
      return true;
    }());
  }

  static void register(
      ToastNavigatorObserverProxy botToastNavigatorObserverProxy) {
    assert(debugInitialization, """
    Please initialize!
    Example:
    ToastInit(
      child:MaterialApp(
      title: 'Xxxx Demo',
      navigatorObservers: [ToastNavigatorObserver()],
      home: XxxxPage(),
    ));
    """);
    assert(botToastNavigatorObserverProxy != null);
    _leavePageCallbacks.add(botToastNavigatorObserverProxy);
  }

  static void unregister(
      ToastNavigatorObserverProxy botToastNavigatorObserverProxy) {
    assert(botToastNavigatorObserverProxy != null);
    _leavePageCallbacks.remove(botToastNavigatorObserverProxy);
  }

  ToastNavigatorObserver._();

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (ToastNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didPush?.call(route, previousRoute);
    }
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (ToastNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didReplace?.call(newRoute, oldRoute);
    }
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic> previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (ToastNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didRemove?.call(route, previousRoute);
    }
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    final copy = _leavePageCallbacks.toList(growable: false);
    for (ToastNavigatorObserverProxy observerProxy in copy) {
      observerProxy.didPop?.call(route, previousRoute);
    }
  }
}
