import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String imageUrl; //占位图
  final String desc; //描述
  final bool hideBtn; //是否隐藏重新加载按钮
  final OnBtnClickListener listener;

  EmptyPage({@required this.imageUrl, this.desc, this.hideBtn, this.listener});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(width: 120, height: 120, child: Image.asset(imageUrl)),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              desc ?? "",
              style: TextStyle(fontSize: 13, color: Color(0xffc6cdd3)),
            ),
          ),
          _buildRetryBtn(hideBtn ?? false, listener)
        ],
      ),
    );
  }
}

Widget _buildRetryBtn(bool hideBtn, OnBtnClickListener listener) {
  if (!hideBtn) {
    return Container(
      height: 40,
      margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
      decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Color(0xffFFE251), Color(0xffFDD108)]),
          borderRadius: BorderRadius.circular(20)),
      child: FlatButton(
        onPressed: () {
          listener.onTap();
        },
        highlightColor: Color(0xffFFE251),
        child: Text(
          "重新加载",
          style: TextStyle(fontSize: 16, color: Color(0xff343a40)),
        ),
      ),
    );
  } else {
    return Container();
  }
}

abstract class OnBtnClickListener {
  void onTap();
}
