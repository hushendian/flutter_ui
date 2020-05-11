import 'package:flutter/material.dart';

import 'picker_popup_route.dart';

class InheritRouteWidget extends InheritedWidget {
  final CityPickerRoute router;

  InheritRouteWidget({Key key, @required this.router, Widget child})
      : super(key: key, child: child);

  static InheritRouteWidget of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(InheritRouteWidget);
  }

  @override
  bool updateShouldNotify(InheritRouteWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return oldWidget.router != router;
  }
}
