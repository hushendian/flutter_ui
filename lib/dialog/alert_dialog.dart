import 'package:flutter/material.dart';

import '../CustomViewDialog.dart';

CustomViewDialog YYAlertDialogBody() {
  return CustomViewDialog().build()
    ..width = 240
    ..borderRadius = 4.0
    ..text(
      padding: EdgeInsets.all(18.0),
      text: "Discard draft?skdnksndskndks大幅度发大饭店",
      color: Colors.grey[700],
    )
    ..buildDialog(
      padding: EdgeInsets.only(top: 20.0),
      gravity: Gravity.right,
      textLeft: "CANCEL",
      colorLeft: Colors.deepPurpleAccent,
      fontSizeLeft: 14.0,
      fontWeightLeft: FontWeight.bold,
      textRight: "DISCARD",
      colorRight: Colors.deepPurpleAccent,
      fontSizeRight: 14.0,
      fontWeightRight: FontWeight.bold,
    )
    ..show();
}

CustomViewDialog YYAlertDialogHeadAndBody() {
  return CustomViewDialog().build()
    ..width = 260
    ..borderRadius = 4.0
    ..text(
      padding: EdgeInsets.all(18.0),
      text: "Use location service?",
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    )
    ..text(
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      text:
          "Let us help apps determine location. This means sending anonymous location data to us, even when no apps are running.",
      color: Colors.grey[500],
      fontSize: 15.0,
    )
    ..buildDialog(
      padding: EdgeInsets.only(top: 20.0),
      gravity: Gravity.right,
      textLeft: "DISAGREE",
      colorLeft: Colors.deepPurpleAccent,
      fontSizeLeft: 14.0,
      onTapLeft: () {
        print("AAAAAAAAA1");
      },
      textRight: "AGREE",
      colorRight: Colors.deepPurpleAccent,
      fontSizeRight: 14.0,
      colorBgLeft: [Colors.grey[300], Colors.grey[300]],
      radius: 20.0,
      onTapRight: () {
        print("BBBBBBBB1");
      },
    )
    ..show();
}

CustomViewDialog YYAlertDialogWithDivider() {
  return CustomViewDialog().build()
    ..width = 220
    ..borderRadius = 4.0
    ..text(
      padding: EdgeInsets.all(25.0),
      alignment: Alignment.center,
      text: "确定要退出登录吗?",
      color: Colors.black,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
    )
    ..divider()
    ..buildDialog(
      padding: EdgeInsets.only(top: 10.0),
      gravity: Gravity.center,
      withDivider: true,
      textLeft: "取消",
      colorLeft: Colors.redAccent,
      fontSizeLeft: 14.0,
      fontWeightLeft: FontWeight.bold,
      onTapLeft: () {
        print("取消");
      },
      textRight: "确定",
      colorRight: Colors.redAccent,
      fontSizeRight: 14.0,
      fontWeightRight: FontWeight.bold,
      onTapRight: () {
        print("确定");
      },
    )
    ..show();
}

CustomViewDialog YYAlertDialogWithGravity({width, gravity, doubleButtonGravity}) {
  return CustomViewDialog().build()
    ..width = width
    ..gravity = gravity
    ..gravityAnimationEnable = true
    ..borderRadius = 4.0
    ..text(
      padding: EdgeInsets.all(18.0),
      text: "Use location service?",
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    )
    ..text(
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      text:
          "Let us help apps determine location. This means sending anonymous location data to us, even when no apps are running.",
      color: Colors.grey[500],
      fontSize: 15.0,
    )
    ..buildDialog(
      padding: EdgeInsets.only(top: 20.0),
      gravity: doubleButtonGravity ?? Gravity.right,
      textLeft: "DISAGREE",
      colorLeft: Colors.deepPurpleAccent,
      fontSizeLeft: 14.0,
      textRight: "AGREE",
      colorRight: Colors.deepPurpleAccent,
      fontSizeRight: 14.0,
    )
    ..show();
}

CustomViewDialog YYAlertDialogWithScaleIn() {
  return CustomViewDialog().build()
    ..width = 240
    ..borderRadius = 4.0
    ..duration = Duration(milliseconds: 500)
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..text(
      padding: EdgeInsets.all(18.0),
      text: "Dialog header",
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    )
    ..text(
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      text: "Dialog body text",
      color: Colors.grey[500],
    )
    ..buildDialog(
      padding: EdgeInsets.only(top: 24.0),
      gravity: Gravity.center,
      textLeft: "ACTION 1",
      colorLeft: Colors.deepPurpleAccent,
      fontSizeLeft: 14.0,
      textRight: "ACTION 2",
      colorRight: Colors.deepPurpleAccent,
      fontSizeRight: 14.0,
    )
    ..show();
}

CustomViewDialog YYAlertDialogWithFadeIn() {
  return CustomViewDialog().build()
    ..width = 240
    ..borderRadius = 4.0
    ..duration = Duration(milliseconds: 500)
    ..animatedFunc = (child, animation) {
      return FadeTransition(
        child: child,
        opacity: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..text(
      padding: EdgeInsets.all(18.0),
      text: "Dialog header",
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    )
    ..text(
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      text: "Dialog body text",
      color: Colors.grey[500],
    )
    ..buildDialog(
      padding: EdgeInsets.only(top: 24.0),
      gravity: Gravity.center,
      textLeft: "ACTION 1",
      colorLeft: Colors.deepPurpleAccent,
      fontSizeLeft: 14.0,
      textRight: "ACTION 2",
      colorRight: Colors.deepPurpleAccent,
      fontSizeRight: 14.0,
    )
    ..show();
}

CustomViewDialog YYAlertDialogWithRotateIn() {
  return CustomViewDialog().build()
    ..width = 240
    ..borderRadius = 4.0
    ..duration = Duration(milliseconds: 500)
    ..animatedFunc = (child, animation) {
      return RotationTransition(
        child: child,
        turns: Tween(begin: 0.0, end: 3.0).animate(animation),
      );
    }
    ..text(
      padding: EdgeInsets.all(18.0),
      text: "Dialog header",
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    )
    ..text(
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      text: "Dialog body text",
      color: Colors.grey[500],
    )
    ..buildDialog(
      padding: EdgeInsets.only(top: 24.0),
      gravity: Gravity.center,
      textLeft: "ACTION 1",
      colorLeft: Colors.deepPurpleAccent,
      fontSizeLeft: 14.0,
      textRight: "ACTION 2",
      colorRight: Colors.deepPurpleAccent,
      fontSizeRight: 14.0,
    )
    ..show();
}

CustomViewDialog YYAlertDialogWithCustomIn() {
  return CustomViewDialog().build()
    ..width = 240
    ..borderRadius = 4.0
    ..duration = Duration(milliseconds: 500)
    ..animatedFunc = (child, animation) {
      return Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()
          ..translate(
            0.0,
            Tween<double>(begin: -50.0, end: 50.0)
                .animate(
                  CurvedAnimation(curve: Interval(0.1, 0.5), parent: animation),
                )
                .value,
          )
          ..scale(
            Tween<double>(begin: 0.5, end: 1.0)
                .animate(
                  CurvedAnimation(curve: Interval(0.5, 0.9), parent: animation),
                )
                .value,
          ),
        child: child,
      );
    }
    ..text(
      padding: EdgeInsets.all(18.0),
      text: "Dialog header",
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    )
    ..text(
      padding: EdgeInsets.only(left: 18.0, right: 18.0),
      text: "Dialog body text",
      color: Colors.grey[500],
    )
    ..buildDialog(
      padding: EdgeInsets.only(top: 24.0),
      gravity: Gravity.center,
      textLeft: "ACTION 1",
      colorLeft: Colors.deepPurpleAccent,
      fontSizeLeft: 14.0,
      textRight: "ACTION 2",
      colorRight: Colors.deepPurpleAccent,
      fontSizeRight: 14.0,
    )
    ..show();
}

CustomViewDialog CustomViewDialogDemo() {
  return CustomViewDialog().build()
    ..width = 220
    ..height = 500
    ..barrierColor = Colors.black.withOpacity(.3)
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..borderRadius = 4.0
    ..widget(
      Padding(
        padding: EdgeInsets.all(0.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "",
            style: TextStyle(
              color: Colors.black,
              fontSize: 14.0,
              fontWeight: FontWeight.w100,
            ),
          ),
        ),
      ),
    )
    ..show();
}

CustomViewDialog YYAlertDialogPopMenu() {
  return CustomViewDialog().build()
    ..width = 120
    ..borderRadius = 8.0
    ..gravity = Gravity.rightTop
    ..barrierColor = Colors.transparent
    ..margin = EdgeInsets.only(top: 80, right: 20)
    ..text(
      padding: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
      text: "Edit Libary",
      fontSize: 16.0,
      color: Colors.grey[700],
    )
    ..text(
      padding: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
      text: "Read History",
      fontSize: 16.0,
      color: Color(0xFFFF6B2D),
    )
    ..show();
}

CustomViewDialog YYAlertDialogCustomXY() {
  return CustomViewDialog().build()
    ..width = 120
    ..borderRadius = 8.0
    ..barrierColor = Colors.transparent
    ..text(
      padding: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
      text: "Edit Libary",
      fontSize: 16.0,
      color: Colors.grey[700],
    )
    ..text(
      padding: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
      text: "Read History",
      fontSize: 16.0,
      color: Color(0xFFFF6B2D),
    )
    ..show(80.0, 100.0);
}
