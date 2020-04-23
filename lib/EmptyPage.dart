import 'package:flutter/material.dart';

class EmptyPage extends StatelessWidget {
  final String imageUrl; //占位图
  final String desc; //描述
  bool hideBtn; //是否隐藏重新加载按钮
  OnBtnClickListener listener;
  Color borderColor;
  Color textColor;
  double textSize;
  double borderRadius;
  String btnText;
  List<Color> list;

  EmptyPage(
      {@required this.imageUrl,
      this.desc,
      this.hideBtn,
      this.listener,
      this.textSize,
      this.textColor,
      this.borderColor,
      this.borderRadius,
      this.btnText,
      this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
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
            _buildRetryBtn()
          ],
        ),
      ),
    );
  }

  Widget _buildRetryBtn() {
    var _hideBtn = hideBtn ?? false;
    var _list = list ?? [Color(0xffFFE251), Color(0xffFDD108)];
    if (!_hideBtn) {
      return Container(
        height: 40,
        margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor ?? Colors.black),
            gradient: LinearGradient(colors: _list),
            borderRadius: BorderRadius.circular(borderRadius ?? 20)),
        child: FlatButton(
          onPressed: () {
            listener.onTap();
          },
          highlightColor: Color(0xffFFE251),
          child: Text(
            btnText ?? "重新加载",
            style: TextStyle(
                fontSize: textSize ?? 16,
                color: textColor ?? Color(0xff343a40)),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}

abstract class OnBtnClickListener {
  void onTap();
}
