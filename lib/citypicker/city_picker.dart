import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'ItemWidgetBuilder.dart';
import 'base.dart';
import 'city_pickers.dart';
import 'picker_popup_route.dart';
import 'show_types.dart';

class CityPickers {
  static Future<Result> showCityPicker(
      {@required BuildContext context,
      showType = ShowType.pca,
      double height = 200.0,
      List<String> provinceList,
      List<List<String>> cityList,
      List<List<String>> areas,
      // CityPickerRoute params
      bool barrierDismissible = true,
      double barrierOpacity = 0.5,
      ItemWidgetBuilder itemBuilder,
      double itemExtent,
      Widget cancelWidget,
      Widget confirmWidget,
      String title}) {
    return Navigator.of(context, rootNavigator: true).push(
      new CityPickerRoute(
          canBarrierDismiss: barrierDismissible,
          barrierOpacity: barrierOpacity,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          child: BaseView(
            showType: showType,
            height: height,
            itemExtent: itemExtent,
            itemBuilder: itemBuilder,
            provinceList: provinceList,
            cityList: cityList,
            areas: areas,
            title: title,
            cancelWidget: cancelWidget,
            confirmWidget: confirmWidget,
          )),
    );
  }
}
