import 'package:flutter/material.dart';
import 'package:flutter_app/TabItem.dart';

import 'CustomerTabLayout.dart';

class CustomerTabLayoutRoute extends StatelessWidget
    implements OnTabClickListener {
  List<String> listTitle = [
    "新闻",
    "音乐",
    "军事",
    "科技",
  ];
  List<Widget> listWidget = [
    Center(child: Text("新闻")),
    Center(child: Text("音乐")),
    Center(child: Text("军事")),
    Center(child: Text("科技")),
  ];

  List<TabItem> _buildListWidget() {
    var list = List<TabItem>();
    for (var i = 0; i < listTitle.length; i++) {
      var tabItem = TabItem();
      tabItem.childWidget = listWidget[i];
      tabItem.tabTitle = listTitle[i];
      list.add(tabItem);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return CustomerTabLayout(
      list: _buildListWidget(),
      onTapListener: this,
    );
  }

  @override
  onTap(int index) {
    print("点击item: " + index.toString());
  }
}
