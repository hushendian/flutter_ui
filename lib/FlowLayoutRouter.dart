import 'package:flutter/material.dart';
import 'package:flutter_app/FlowLayout.dart';

class FlowLayoutRouter extends StatelessWidget implements OnItemClickListener {
  List<String> list = ["乒乓球", "篮球", "羽毛球", "棒球", "是你的就是你的","我的还是我的"];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
          child: FlowLayout(
            list: list,
            listener: this,
            selectColor: Colors.yellow,
            maxSelectSize: 9,
          ),
        ),
      ),
    );
  }

  @override
  onItemClick(List<String> text) {
    print("最终选择的" + text.toString());
  }
}
