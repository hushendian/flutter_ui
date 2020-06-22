import 'package:flutter/material.dart';
import 'package:flutter_app/text.dart';
import 'package:flutter_app/toast/bot_toast_init.dart';
import 'package:flutter_app/toast/toast_navigator_observer.dart';

import 'CustomViewDialog.dart';
import 'dialog/alert_dialog.dart';
import 'dialog/progress_dialog.dart';

class ToastRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ToastInit(
      child: MaterialApp(
        navigatorObservers: [ToastNavigatorObserver()],
        home:TextSample(),
      ),
    );
  }
}


class EnterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BotToast"),
          centerTitle: true,
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: Column(children: <Widget>[
                Container(
                  height: 40,
                ),
                Text(
                  "TextToast",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 10),
                        child: RaisedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => TextSample()));
                          },
                          child: Text("TextToast"),
                        ),
                      ),
                    ),
                  ],
                )
              ]),
            ),
          ),
        ));
  }
}