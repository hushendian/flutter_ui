import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/CustomerTabLayoutRoute.dart';
import 'package:flutter_app/FlowLayoutRouter.dart';

import 'SharePopupRouter.dart';

class MainPanel extends StatelessWidget {
  Widget _buildPanelWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text("通用dialog"),
          onTap: () {},
        ),
        ListTile(
          title: Text("通用FlowLayout"),
          onTap: () {
            toOtherPage(context, FlowLayoutRouter());
          },
        ),
        ListTile(
          title: Text("通用TabLayout"),
          onTap: () {
            toOtherPage(context, CustomerTabLayoutRoute());
          },
        ),
        ListTile(
          title: Text("通用BottomSheet"),
          onTap: () {
            toOtherPage(context, SharePopupRouter());
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildPanelWidget(context);
  }

  toOtherPage(BuildContext context, Widget widget) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
  }
}
