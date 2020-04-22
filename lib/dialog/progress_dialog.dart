import 'package:flutter/material.dart';

import '../CustomViewDialog.dart';

CustomViewDialog YYProgressDialogNoBody() {
  return CustomViewDialog().build()
    ..borderRadius = 4.0
    ..circularProgress(
      padding: EdgeInsets.all(24.0),
      valueColor: Color(0xffFFE251),
    )
    ..show();
}

CustomViewDialog YYProgressDialogBody() {
  return CustomViewDialog().build()
    ..width = 200
    ..borderRadius = 4.0
    ..circularProgress(
      padding: EdgeInsets.all(24.0),
      valueColor: Color(0xffFFE251),
    )
    ..text(
      padding: EdgeInsets.fromLTRB(18.0, 0.0, 18.0, 12.0),
      text: "正在加载中...",
      alignment: Alignment.center,
      color: Colors.black,
      fontSize: 14.0,
    )
    ..show();
}
