class ItemBean {
  String icon;
  String title;
  int index;

  ItemBean({this.icon, this.title, this.index});

  @override
  String toString() {
    return 'ItemBean{icon: $icon, title: $title, index: $index}';
  }
}
