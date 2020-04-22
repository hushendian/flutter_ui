import 'package:flutter/material.dart';

import 'BlurRectWidget.dart';

class BlurRectWidgetRoute extends StatefulWidget {
  @override
  _BlurRectWidgetRoute createState() => _BlurRectWidgetRoute();
}

class _BlurRectWidgetRoute extends State<BlurRectWidgetRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Stack(
          overflow: Overflow.clip,
          alignment: Alignment(-1, 1),
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffF3F4F5),
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                          "https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1585127956&di=59565e99ae8f458b78b5696ca5b49b1b&src=http://attach.bbs.miui.com/forum/201310/19/235356fyjkkugokokczyo0.jpg"),
                      fit: BoxFit.cover) //设置图片的填充模式
                  ),
              margin: EdgeInsets.only(bottom: 20),
            ),
            // 矩形高斯模糊效果
            BlurRectWidget(
              child: Container(),
              sigmaY: 10,
              sigmaX: 10,
            ),
          ]),
    );
  }

  onTap() {
    print("button click");
  }
}
