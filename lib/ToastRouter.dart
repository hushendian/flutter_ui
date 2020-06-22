import 'package:flutter/material.dart';

import 'CustomViewDialog.dart';
import 'dialog/alert_dialog.dart';
import 'dialog/progress_dialog.dart';

class DialogRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Dialog demo"),
        ),
        body: new Center(child: showAlertDialog()));
  }
}

showAlertDialog() {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        makeTextButton("body", () {
          YYAlertDialogBody();
        }),
        makeTextButton("head&body", () {
          YYAlertDialogHeadAndBody();
        }),
        makeTextButton("divider", () {
          YYAlertDialogWithDivider();
        }),
        makeTextButton("progress", () {
          YYProgressDialogNoBody();
        }),
        makeTextButton("progress\n&body", () {
          YYProgressDialogBody();
        }),
        makeTextButton("center", () {
          YYAlertDialogWithGravity(
            width: 250.0,
            gravity: Gravity.center,
          );
        }),
      ],
    ),
  );
}

Widget makeTextButton(title, Function() function) {
  return SizedBox(
    width: 70.0,
    height: 35.0,
    child: RaisedButton(
      padding: EdgeInsets.all(0.0),
      onPressed: () {
        function();
      },
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 12.0),
      ),
    ),
  );
}
