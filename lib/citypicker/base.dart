/**
 * Created with Android Studio.
 * User: 三帆
 * Date: 28/01/2019
 * Time: 18:20
 * email: sanfan.hx@alibaba-inc.com
 * tartget:  xxx
 */
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ItemWidgetBuilder.dart';
import 'city_pickers.dart';
import 'inherit_process.dart';
import 'show_types.dart';

class BaseView extends StatefulWidget {
  final double progress;
  final ShowType showType;
  final ItemWidgetBuilder itemBuilder;
  final List<String> provinceList;
  final List<List<String>> cityList;
  final List<List<String>> areas;
  final String title;

  /// ios选择框的高度. 配合 itemBuilder中的字体使用.
  final double itemExtent;

  /// 容器高度
  final double height;

  /// 取消按钮的Widget
  /// 当用户设置该属性. 会优先使用用户设置的widget, 否则使用代码中默认的文本, 使用primary主题色
  final Widget cancelWidget;

  /// 确认按钮的widget
  /// 当用户设置该属性. 会优先使用用户设置的widget, 否则使用代码中默认的文本, 使用primary主题色
  final Widget confirmWidget;

  BaseView({
    this.progress,
    this.showType,
    this.height,
    this.provinceList,
    this.cityList,
    this.areas,
    this.itemBuilder,
    this.itemExtent,
    this.cancelWidget,
    this.confirmWidget,
    this.title,
  }) : assert(!(itemBuilder != null && itemExtent == null),
            "\ritemExtent could't be null if itemBuilder exits");

  _BaseView createState() => _BaseView();
}

class _BaseView extends State<BaseView> {
  Timer _changeTimer;
  bool _resetControllerOnce = false;
  FixedExtentScrollController provinceController;
  FixedExtentScrollController cityController;
  FixedExtentScrollController areaController;

  // 所有省的列表. 因为性能等综合原因,
  // 没有一次性构建整个以国为根的树. 动态的构建以省为根的树, 效率高.
  List<String> provinces;
  List<String> citys;
  List<String> areas;

  String targetProvince;
  String targetCity;
  String targetArea;
  int provinceIndex = 0;
  int cityIndex = 0;

  @override
  void initState() {
    super.initState();
    targetProvince = widget.provinceList[0];
    targetCity = widget.cityList != null ? widget.cityList[0][0] : "";
    targetArea = widget.areas != null ? widget.areas[0][0] : "";
//    cityTree = new CityTree(
//        metaInfo: widget.cityList, provincesInfo: widget.provinceList);
    _initController();
  }

  void dispose() {
    provinceController.dispose();
    cityController.dispose();
    areaController.dispose();
    if (_changeTimer != null && _changeTimer.isActive) {
      _changeTimer.cancel();
    }
    super.dispose();
  }

  // 初始化controller, 为了使给定的默认值, 在选框的中心位置
  void _initController() {
    provinceController = new FixedExtentScrollController();

    cityController = new FixedExtentScrollController();

    areaController = new FixedExtentScrollController();
  }

  // 重置Controller的原因在于, 无法手动去更改initialItem, 也无法通过
  // jumpTo or animateTo去更改, 强行更改, 会触发 _onProvinceChange  _onCityChange 与 _onAreacChange
  // 只为覆盖初始化化的参数initialItem
  void _resetController() {
    if (_resetControllerOnce) return;
    provinceController = new FixedExtentScrollController(initialItem: 0);

    cityController = new FixedExtentScrollController(initialItem: 0);
    areaController = new FixedExtentScrollController(initialItem: 0);
    _resetControllerOnce = true;
  }

  // province change handle
  // 加入延时处理, 减少构建树的消耗
  _onProvinceChange(String _province, List _city, List _areas) {
    if (_changeTimer != null && _changeTimer.isActive) {
      _changeTimer.cancel();
    }
    _changeTimer = new Timer(Duration(milliseconds: 500), () {
      setState(() {
        targetProvince = _province;
        targetCity = _city != null ? _city[0] : "";
        targetArea = _areas != null ? _areas[0] : "";
        _resetController();
      });
    });
  }

  _onCityChange(String _city, List _areas) {
    if (_changeTimer != null && _changeTimer.isActive) {
      _changeTimer.cancel();
    }
    _changeTimer = new Timer(Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        targetCity = _city;
        targetArea = _areas[0];
      });
    });
    _resetController();
  }

  _onAreaChange(String _targetArea) {
    if (_changeTimer != null && _changeTimer.isActive) {
      _changeTimer.cancel();
    }
    _changeTimer = new Timer(Duration(milliseconds: 500), () {
      if (!mounted) return;
      setState(() {
        targetArea = _targetArea;
      });
    });
  }

  Result _buildResult() {
    Result result = Result();
    ShowType showType = widget.showType;
    if (showType.contain(ShowType.p)) {
      result.provinceName = targetProvince;
    }
    if (showType.contain(ShowType.c)) {
      result.provinceName = targetProvince;
      result.cityName = targetCity != null ? targetCity : null;
    }
    if (showType.contain(ShowType.a)) {
      result.provinceName = targetProvince;
      result.cityName = targetCity != null ? targetCity : null;
      result.areaName = targetArea != null ? targetArea : null;
    }
    return result;
  }

  Widget _bottomBuild() {
    return new Container(
        width: double.infinity,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            new Row(
              children: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: widget.cancelWidget ??
                      new Text(
                        '取消',
                        style: new TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                ),
                FlatButton(
                  child: widget.cancelWidget ??
                      new Text(
                        widget.title ?? widget.title,
                        style: new TextStyle(
                          color: Color(0xff343a40),
                        ),
                      ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, _buildResult());
                  },
                  child: widget.confirmWidget ??
                      new Text(
                        '确定',
                        style: new TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                ),
              ],
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Expanded(
              child: new Row(
                children: <Widget>[
                  new _MyCityPicker(
                    key: Key('province'),
                    isShow: widget.showType.contain(ShowType.p),
                    height: widget.height,
                    controller: provinceController,
                    itemBuilder: widget.itemBuilder,
                    itemExtent: widget.itemExtent,
                    value: targetProvince,
                    itemList: widget.provinceList,
                    changed: (index) {
                      provinceIndex = index;
                      cityIndex = 0;
                      _onProvinceChange(
                          widget.provinceList[index],
                          widget.cityList != null
                              ? widget.cityList[index]
                              : null,
                          widget.areas != null
                              ? widget.areas[
                                  _buildPosition(provinceIndex, cityIndex)]
                              : null);
                    },
                  ),
                  new _MyCityPicker(
                    key: Key('citys $targetProvince'),
                    // 这个属性是为了强制刷新
                    isShow: widget.showType.contain(ShowType.c),
                    controller: cityController,
                    itemBuilder: widget.itemBuilder,
                    itemExtent: widget.itemExtent,
                    height: widget.height,
                    value: targetCity == null ? null : targetCity,
                    itemList: widget.cityList != null
                        ? widget.cityList[provinceIndex]
                        : null,
                    changed: (index) {
                      if (widget.cityList == null) {
                        return;
                      }
                      cityIndex = index;
                      _onCityChange(
                          widget.cityList[provinceIndex][index],
                          widget
                              .areas[_buildPosition(provinceIndex, cityIndex)]);
                    },
                  ),
                  new _MyCityPicker(
                    key: Key('towns $targetCity'),
                    isShow: widget.showType.contain(ShowType.a),
                    controller: areaController,
                    itemBuilder: widget.itemBuilder,
                    itemExtent: widget.itemExtent,
                    value: targetArea == null ? null : targetArea,
                    height: widget.height,
                    itemList: widget.areas != null
                        ? widget.areas[_buildPosition(provinceIndex, cityIndex)]
                        : null,
                    changed: (index) {
                      if (widget.areas == null) {
                        return;
                      }
                      _onAreaChange(
                          widget.areas[_buildPosition(provinceIndex, cityIndex)]
                              [index]);
                    },
                  )
                ],
              ),
            )
          ],
        ));
  }

  int _buildPosition(int provinceIndex, int cityIndex) {
    int num = 0;
    for (var i = 0; i < provinceIndex; i++) {
      num += widget.cityList[i].length;
    }
    num += cityIndex;
    return num;
  }

  Widget build(BuildContext context) {
    final route = InheritRouteWidget.of(context).router;
    return new AnimatedBuilder(
      animation: route.animation,
      builder: (BuildContext context, Widget child) {
        return new CustomSingleChildLayout(
          delegate: _WrapLayout(
              progress: route.animation.value, height: widget.height),
          child: new GestureDetector(
            child: new Material(
              color: Colors.transparent,
              child:
                  new Container(width: double.infinity, child: _bottomBuild()),
            ),
          ),
        );
      },
    );
  }
}

class _MyCityPicker extends StatefulWidget {
  final List<String> itemList;
  final Key key;
  final String value;
  final bool isShow;
  final FixedExtentScrollController controller;
  final ValueChanged<int> changed;
  final double height;
  final ItemWidgetBuilder itemBuilder;

  // ios选择框的高度. 配合 itemBuilder中的字体使用.
  final double itemExtent;

  _MyCityPicker(
      {this.key,
      this.controller,
      this.isShow = false,
      this.changed,
      this.height,
      this.itemList,
      this.itemExtent,
      this.itemBuilder,
      this.value});

  @override
  State createState() {
    return new _MyCityPickerState();
  }
}

class _MyCityPickerState extends State<_MyCityPicker> {
  List<Widget> children;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isShow) {
      return Container();
    }
    if (widget.itemList == null || widget.itemList.isEmpty) {
      return new Expanded(
        child: Container(),
      );
    }
    return new Expanded(
      child: new Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          padding: const EdgeInsets.all(6.0),
          alignment: Alignment.center,
          child: CupertinoPicker.builder(
              magnification: 1.0,
              itemExtent: widget.itemExtent ?? 40.0,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              scrollController: widget.controller,
              onSelectedItemChanged: (index) {
                widget.changed(index);
              },
              itemBuilder: (context, index) {
                if (widget.itemBuilder != null) {
                  return widget.itemBuilder(
                      widget.itemList[index], widget.itemList, index);
                }
                return Center(
                  child: Text(
                    '${widget.itemList[index]}',
                    maxLines: 1,
                  ),
                );
              },
              childCount: widget.itemList.length)),
      flex: 1,
    );
  }
}

class _WrapLayout extends SingleChildLayoutDelegate {
  _WrapLayout({
    this.progress,
    this.height,
  });

  final double progress;
  final double height;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    double maxHeight = height;

    return new BoxConstraints(
      minWidth: constraints.maxWidth,
      maxWidth: constraints.maxWidth,
      minHeight: 0.0,
      maxHeight: maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    double height = size.height - childSize.height * progress;
    return new Offset(0.0, height);
  }

  @override
  bool shouldRelayout(_WrapLayout oldDelegate) {
    return progress != oldDelegate.progress;
  }
}
