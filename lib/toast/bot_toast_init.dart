import 'package:flutter/material.dart';

import 'bot_toast_manager.dart';

final GlobalKey<ToastInitState> _botToastInitKey =
GlobalKey<ToastInitState>();

ToastManager get botToastManager {
  assert(_botToastInitKey?.currentState?._botToastManager != null);
  return _botToastInitKey.currentState._botToastManager;
}

class ToastInit extends StatefulWidget {
  final Widget child;

  ToastInit({@required this.child})
      : assert(child != null),
        super(key: _botToastInitKey);

  @override
  ToastInitState createState() => ToastInitState();
}

class ToastInitState extends State<ToastInit> {
  bool _needInit;
  bool get needInit => _needInit;

  ToastManager _botToastManager;

  void reset() {
    _needInit = false;
  }

  @override
  Widget build(BuildContext context) {
    _needInit = true;
    return widget.child;
  }

  @override
  void initState() {
    _needInit = true;
    _botToastManager = ToastManager(this);
    super.initState();
  }

  @override
  void dispose() {
    _botToastManager.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(ToastInit oldWidget) {
    _needInit = true;
    super.didUpdateWidget(oldWidget);
  }
}
