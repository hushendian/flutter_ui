import 'package:flutter/material.dart';
import 'package:flutter_app/CustomViewDialog.dart';
import 'package:flutter_app/MainPanel.dart';
import 'package:flutter_app/text.dart';
import 'package:flutter_app/toast/bot_toast_init.dart';
import 'package:flutter_app/toast/toast_navigator_observer.dart';

import 'CustomerTabLayoutRoute.dart';
import 'EmptyPage.dart';
import 'FlowLayout.dart';
import 'FlowLayoutRouter.dart';
import 'SharePopupRouter.dart';
import 'SharePopupWindow.dart';
import 'dialog/alert_dialog.dart';
import 'dialog/progress_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget implements OnBtnClickListener {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "tttttttttt",
      home: Scaffold(
        appBar: AppBar(
          title: Text("通用UI控件"),
        ),
        body: MainPanel(),
      ),
    );
  }

  @override
  void onTap() {
    print("重新加载数据");
  }
}

class AppHome extends StatelessWidget {
  Widget build(BuildContext context) {
    //1、初始化context
    CustomViewDialog.init(context);
    //2、后续使用可以不需要context
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            showAlertDialog(),
          ],
        ),
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

showAlertDialog() {
  return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "YYAlertDialog",
          ),
          Text("1、demo"),
          Row(
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
            ],
          ),
          Row(
            children: <Widget>[
              makeTextButton("progress", () {
                YYProgressDialogNoBody();
              }),
              makeTextButton("progress\n&body", () {
                YYProgressDialogBody();
              }),
              makeTextButton("custom\nx&y", () {
                YYAlertDialogCustomXY();
              }),
            ],
          ),
          Text("3、dialog gravity"),
          makeTextButton("center", () {
            YYAlertDialogWithGravity(
              width: 250.0,
              gravity: Gravity.center,
            );
          }),
        ],
      ));
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

class Test extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("222"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      height: 200.0,
                      color: Color(0xfff1f1f1),
                      child: Center(
                        child: Text("底部面板,点击消失"),
                      ),
                    );
                  },
                );
              },
              child: Text("底部面板,点击消失"),
            ),
            RaisedButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return GestureDetector(
                      child: Container(
                        height: 2000.0,
                        color: Color(0xfff1f1f1),
                        child: Center(
                          child: Text("底部面板,点击底部面板不消失"),
                        ),
                      ),
                      onTap: () => false,
                    );
                  },
                );
              },
              child: Text("底部面板,点击底部面板不消失"),
            ),
          ],
        ),
      ),
    );
  }
}
