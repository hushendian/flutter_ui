import 'package:flutter/material.dart';

class TabItem {
  String tabTitle;
  Widget childWidget;

  @override
  String toString() {
    return 'TabItem{tabTitle: $tabTitle, childWidget: $childWidget}';
  }
}
