import 'package:flutter/material.dart';
import 'package:flutter_app/SharePopupWindow.dart';

import 'ItemBean.dart';

class SharePopupRouter extends StatelessWidget implements OnItemClickListener {
  List<String> nameItems = <String>[
    '微信',
    '朋友圈',
    'QQ',
    'QQ空间',
    '微博',
    '微师',
    '微为',
    '微问',
    '微未',
  ];
  List<String> urlItems = <String>[
    'images/icon_man.png',
    'images/icon_man.png',
    'images/icon_man.png',
    'images/icon_man.png',
    'images/icon_man.png',
    'images/icon_man.png',
    'images/icon_man.png',
    'images/icon_man.png',
    'images/icon_man.png',
  ];

  List<ItemBean> _buildItemList() {
    var list = List<ItemBean>();
    for (var i = 0; i < 9; i++) {
      var item = ItemBean();
      item.title = nameItems[i];
      item.icon = urlItems[i];
      list.add(item);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("分享页面"),
        ),
        body: new Center(
          child: new Builder(builder: (BuildContext context) {
            return new FlatButton(
                onPressed: () {
                  SharePopupWindow.showBottomSheet(
                      context, _buildItemList(), this, true, null, null);
                },
                child: new Text("我要分享"),
                color: Colors.blue);
          }),
        ));
  }

  @override
  void onItemClick(int index) {
    print(_buildItemList()[index].icon);
    print(_buildItemList()[index].title);
  }
}
