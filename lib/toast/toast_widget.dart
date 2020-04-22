import 'package:flutter/material.dart';
export 'text.dart';

class ProxyInitState extends StatefulWidget {
  final Widget child;
  final VoidCallback initStateCallback;

  const ProxyInitState({Key key, this.initStateCallback, this.child})
      : super(key: key);

  @override
  _ProxyInitStateState createState() => _ProxyInitStateState();
}

class _ProxyInitStateState extends State<ProxyInitState> {
  @override
  void initState() {
    widget.initStateCallback();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

class ProxyDispose extends StatefulWidget {
  final Widget child;
  final VoidCallback disposeCallback;

  const ProxyDispose({
    Key key,
    @required this.disposeCallback,
    @required this.child,
  })  : assert(child != null),
        assert(disposeCallback != null),
        super(key: key);

  @override
  _ProxyDisposeState createState() => _ProxyDisposeState();
}

class _ProxyDisposeState extends State<ProxyDispose> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget.disposeCallback();
    super.dispose();
  }
}
