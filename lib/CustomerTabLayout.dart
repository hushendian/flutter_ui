import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/TabItem.dart';

class CustomerTabLayout extends StatefulWidget {
  final List<TabItem> list;
  TabController controller;
  final bool isScrollable;
  final Color indicatorColor;
  final double indicatorWeight;
  final EdgeInsetsGeometry indicatorPadding;
  final Decoration indicator;
  final TabBarIndicatorSize indicatorSize;
  final Color labelColor;
  final Color unselectedLabelColor;
  final TextStyle labelStyle;
  final EdgeInsetsGeometry labelPadding;
  final TextStyle unselectedLabelStyle;
  final DragStartBehavior dragStartBehavior;
  final OnTabClickListener onTapListener;

  CustomerTabLayout({
    @required this.list,
    this.controller,
    this.isScrollable = false,
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    @required this.onTapListener,
  });

  @override
  _TabControllerPageState createState() => _TabControllerPageState(
      list: list,
      isScrollable: isScrollable,
      indicatorColor: indicatorColor,
      indicatorWeight: indicatorWeight,
      indicatorPadding: indicatorPadding,
      indicator: indicator,
      indicatorSize: indicatorSize,
      labelColor: labelColor,
      labelStyle: labelStyle,
      labelPadding: labelPadding,
      unselectedLabelColor: unselectedLabelColor,
      unselectedLabelStyle: unselectedLabelStyle,
      dragStartBehavior: dragStartBehavior,
      onTapListener: onTapListener);
}

class _TabControllerPageState extends State<CustomerTabLayout>
    with SingleTickerProviderStateMixin {
  final List<TabItem> list;
  TabController controller;
  final bool isScrollable;
  final Color indicatorColor;
  final double indicatorWeight;
  final EdgeInsetsGeometry indicatorPadding;
  final Decoration indicator;
  final TabBarIndicatorSize indicatorSize;
  final Color labelColor;
  final Color unselectedLabelColor;
  final TextStyle labelStyle;
  final EdgeInsetsGeometry labelPadding;
  final TextStyle unselectedLabelStyle;
  final DragStartBehavior dragStartBehavior;
  final OnTabClickListener onTapListener;

  _TabControllerPageState({
    @required this.list,
    this.controller,
    this.isScrollable = false,
    this.indicatorColor,
    this.indicatorWeight = 2.0,
    this.indicatorPadding = EdgeInsets.zero,
    this.indicator,
    this.indicatorSize,
    this.labelColor,
    this.labelStyle,
    this.labelPadding,
    this.unselectedLabelColor,
    this.unselectedLabelStyle,
    this.dragStartBehavior = DragStartBehavior.start,
    @required this.onTapListener,
  });

  @override
  void initState() {
    controller = TabController(vsync: this, length: list.length);
    controller.addListener(() {
      print("hsd" + controller.index.toString());
      onTapListener.onTap(controller.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.white,
          child: TabBar(
            controller: controller,
            indicatorColor: indicatorColor ?? Color(0xfffdd108),
            labelColor: labelColor ?? Color(0xff343a40),
            indicatorSize: indicatorSize ?? TabBarIndicatorSize.label,
            unselectedLabelColor: unselectedLabelColor ?? Color(0xff8E9AA6),
            unselectedLabelStyle: unselectedLabelStyle ??
                TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            indicatorPadding: indicatorPadding ?? EdgeInsets.zero,
            dragStartBehavior: dragStartBehavior ?? DragStartBehavior.start,
            indicatorWeight: indicatorWeight ?? 2,
            isScrollable: isScrollable ?? false,
            // labelPadding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            labelStyle: labelStyle ??
                TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            tabs: _buildTabsWidget(list),
          ),
        ),
        Flexible(
          child: TabBarView(
            controller: controller,
            children: _buildContentWidget(list),
          ),
        )
      ],
    );
  }

  List<Widget> _buildTabsWidget(List<TabItem> tabList) {
    var list = List<Widget>();
    for (var i = 0; i < tabList.length; i++) {
      var widget = Tab(text: tabList[i].tabTitle);
      list.add(widget);
    }
    return list;
  }

  List<Widget> _buildContentWidget(List<TabItem> tabList) {
    var list = List<Widget>();
    for (var i = 0; i < tabList.length; i++) {
      var contentWidget = tabList[i].childWidget;
      list.add(contentWidget);
    }
    return list;
  }
}

abstract class OnTabClickListener {
  onTap(int index);
}
