import 'package:flutter/material.dart';

class CustomViewDialog {
  //================================弹窗属性======================================
  List<Widget> widgetList = []; //弹窗内部所有组件
  static BuildContext _context; //弹窗上下文
  BuildContext context; //弹窗上下文

  double width; //弹窗宽度
  double height; //弹窗高度
  Duration duration = Duration(milliseconds: 250); //弹窗动画出现的时间
  Gravity gravity = Gravity.center; //弹窗出现的位置
  bool gravityAnimationEnable = false; //弹窗出现的位置带有的默认动画是否可用
  Color barrierColor = Colors.black.withOpacity(.3); //弹窗外的背景色
  BoxConstraints constraints; //弹窗约束
  Function(Widget child, Animation<double> animation) animatedFunc; //弹窗出现的动画
  bool barrierDismissible = true; //是否点击弹出外部消失
  EdgeInsets margin = EdgeInsets.all(0.0); //弹窗布局的外边距

  Decoration decoration; //弹窗内的装饰，与backgroundColor和borderRadius互斥
  Color backgroundColor = Colors.white; //弹窗内的背景色
  double borderRadius = 0.0; //弹窗圆角

  Function() showCallBack; //展示的回调
  Function() dismissCallBack; //消失的回调

  get isShowing => _isShowing; //当前弹窗是否可见
  bool _isShowing = false;

  //============================================================================
  static void init(BuildContext ctx) {
    _context = ctx;
  }

  CustomViewDialog build([BuildContext ctx]) {
    if (ctx == null && _context != null) {
      this.context = _context;
      return this;
    }
    this.context = ctx;
    return this;
  }

  CustomViewDialog widget(Widget child) {
    this.widgetList.add(child);
    return this;
  }

  CustomViewDialog text(
      {radius,
      padding,
      text,
      color,
      fontSize,
      alignment,
      textAlign,
      maxLines,
      textDirection,
      overflow,
      fontWeight,
      fontFamily}) {
    return this.widget(
      Padding(
        padding: padding ?? EdgeInsets.all(0.0),
        child: Align(
          alignment: alignment ?? Alignment.center,
          child: Text(
            text ?? "",
            textAlign: textAlign,
            maxLines: maxLines,
            textDirection: textDirection,
            overflow: overflow,
            style: TextStyle(
              color: color ?? Colors.black,
              fontSize: fontSize ?? 14.0,
              fontWeight: fontWeight,
              fontFamily: fontFamily,
            ),
          ),
        ),
      ),
    );
  }

  CustomViewDialog buildDialog({
    radius,
    padding,
    gravity,
    height,
    isClickAutoDismiss = true, //点击按钮后自动关闭
    withDivider = false, //中间分割线
    textLeft,
    colorLeft,
    fontSizeLeft,
    colorBgLeft,
    fontWeightLeft,
    fontFamilyLeft,
    VoidCallback onTapLeft,
    textRight,
    colorRight,
    fontSizeRight,
    colorBgRight,
    fontWeightRight,
    fontFamilyRight,
    onTapRight,
  }) {
    return this.widget(
      Container(
          padding: EdgeInsets.all(10),
          height: height ?? 65.0,
          child: _buildDialogButton(
            radius,
            padding,
            gravity,
            height,
            isClickAutoDismiss,
            withDivider,
            textLeft,
            colorLeft,
            colorBgLeft,
            fontSizeLeft,
            fontWeightLeft,
            fontFamilyLeft,
            onTapLeft,
            textRight,
            colorRight,
            colorBgRight,
            fontSizeRight,
            fontWeightRight,
            fontFamilyRight,
            onTapRight,
          )),
    );
  }

  Widget _buildDialogButton(
    radius,
    padding,
    gravity,
    height,
    isClickAutoDismiss,
    withDivider,
    textLeft,
    colorLeft,
    colorBgLeft,
    fontSizeLeft,
    fontWeightLeft,
    fontFamilyLeft,
    VoidCallback onTapLeft,
    textRight,
    colorRight,
    colorBgRight,
    fontSizeRight,
    fontWeightRight,
    fontFamilyRight,
    onTapRight,
  ) {
    List<Color> _colorsLeft =
        colorBgLeft ?? [Colors.transparent, Colors.transparent];
    List<Color> _colorsRight =
        colorBgRight ?? [Colors.transparent, Colors.transparent];
    double _radius = radius ?? 4;
    var content;
    if (textLeft != null && textRight != null) {
      content = Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: _colorsLeft),
                borderRadius: BorderRadius.circular(_radius)),
            child: FlatButton(
              highlightColor: null,
              onPressed: () {
                if (onTapLeft != null) onTapLeft();
                if (isClickAutoDismiss) {
                  dismiss();
                }
              },
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Text(
                textLeft ?? "",
                style: TextStyle(
                  color: colorLeft ?? null,
                  fontSize: fontSizeLeft ?? null,
                  fontWeight: fontWeightLeft,
                  fontFamily: fontFamilyLeft,
                ),
              ),
            ),
          ),
          Visibility(
            visible: withDivider,
            child: VerticalDivider(),
          ),
          DecoratedBox(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: _colorsRight),
                borderRadius: BorderRadius.circular(_radius)),
            child: FlatButton(
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              highlightColor: null,
              onPressed: () {
                if (onTapRight != null) onTapRight();
                if (isClickAutoDismiss) {
                  dismiss();
                }
              },
              child: Text(
                textRight ?? "",
                style: TextStyle(
                  color: colorRight ?? Colors.black,
                  fontSize: fontSizeRight ?? 14.0,
                  fontWeight: fontWeightRight,
                  fontFamily: fontFamilyRight,
                ),
              ),
            ),
          )
        ],
      );
    } else {
      content = Container(
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: _colorsLeft),
              borderRadius: BorderRadius.circular(_radius)),
          child: FlatButton(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            highlightColor: Colors.white,
            onPressed: () {
              if (onTapLeft != null) onTapLeft();
              if (isClickAutoDismiss) {
                dismiss();
              }
            },
            child: Text(
              textLeft ?? "",
              style: TextStyle(
                color: colorLeft ?? null,
                fontSize: fontSizeLeft ?? null,
                fontWeight: fontWeightLeft,
                fontFamily: fontFamilyLeft,
              ),
            ),
          ),
        ),
      );
    }
    return content;
  }

  CustomViewDialog circularProgress(
      {padding, backgroundColor, valueColor, strokeWidth}) {
    return this.widget(Padding(
      padding: padding,
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth ?? 4.0,
        backgroundColor: backgroundColor,
        valueColor: AlwaysStoppedAnimation<Color>(valueColor),
      ),
    ));
  }

  CustomViewDialog divider({color, height}) {
    return this.widget(
      Divider(
        color: color ?? Colors.grey[300],
        height: height ?? 0.1,
      ),
    );
  }

  ///  x坐标
  ///  y坐标
  void show([x, y]) {
    var mainAxisAlignment = getColumnMainAxisAlignment(gravity);
    var crossAxisAlignment = getColumnCrossAxisAlignment(gravity);
    if (x != null && y != null) {
      gravity = Gravity.center;
      margin = EdgeInsets.only(left: x, top: y);
    }
    CustomDialog(
      gravity: gravity,
      gravityAnimationEnable: gravityAnimationEnable,
      context: this.context,
      barrierColor: barrierColor,
      animatedFunc: animatedFunc,
      barrierDismissible: barrierDismissible,
      duration: duration,
      child: Padding(
        padding: margin,
        child: Column(
          textDirection: TextDirection.ltr,
          mainAxisAlignment: mainAxisAlignment,
          crossAxisAlignment: crossAxisAlignment,
          children: <Widget>[
            Material(
              type: MaterialType.transparency,
              child: Container(
                padding: EdgeInsets.all(borderRadius / 3.14),
                width: width ?? null,
                height: height ?? null,
                decoration: decoration ??
                    BoxDecoration(
                      borderRadius: BorderRadius.circular(borderRadius),
                      color: backgroundColor,
                    ),
                constraints: constraints ?? BoxConstraints(),
                child: CustomDialogChildren(
                  widgetList: widgetList,
                  isShowingChange: (bool isShowingChange) {
                    // showing or dismiss Callback
                    if (isShowingChange) {
                      if (showCallBack != null) {
                        showCallBack();
                      }
                    } else {
                      if (dismissCallBack != null) {
                        dismissCallBack();
                      }
                    }
                    _isShowing = isShowingChange;
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void dismiss() {
    if (_isShowing) {
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  getColumnMainAxisAlignment(gravity) {
    var mainAxisAlignment = MainAxisAlignment.start;
    switch (gravity) {
      case Gravity.center:
      default:
        mainAxisAlignment = MainAxisAlignment.center;
        break;
    }
    return mainAxisAlignment;
  }

  getColumnCrossAxisAlignment(gravity) {
    var crossAxisAlignment = CrossAxisAlignment.center;
    switch (gravity) {
      default:
        break;
    }
    return crossAxisAlignment;
  }

  getRowMainAxisAlignment(gravity) {
    var mainAxisAlignment = MainAxisAlignment.start;
    switch (gravity) {
      case Gravity.center:
      default:
        mainAxisAlignment = MainAxisAlignment.center;
        break;
    }
    return mainAxisAlignment;
  }
}

///弹窗的内容作为可变组件
class CustomDialogChildren extends StatefulWidget {
  final List<Widget> widgetList; //弹窗内部所有组件
  final Function(bool) isShowingChange;

  CustomDialogChildren({this.widgetList = const [], this.isShowingChange});

  @override
  CustomDialogChildState createState() => CustomDialogChildState();
}

class CustomDialogChildState extends State<CustomDialogChildren> {
  @override
  Widget build(BuildContext context) {
    widget.isShowingChange(true);
    return Column(
      children: widget.widgetList,
    );
  }

  @override
  void dispose() {
    widget.isShowingChange(false);
    super.dispose();
  }
}

///弹窗API的封装
class CustomDialog {
  BuildContext _context;
  Widget _child;
  Duration _duration;
  Color _barrierColor;
  RouteTransitionsBuilder _transitionsBuilder;
  bool _barrierDismissible;
  Gravity _gravity;
  bool _gravityAnimationEnable;
  Function _animatedFunc;

  CustomDialog({
    @required Widget child,
    @required BuildContext context,
    Duration duration,
    Color barrierColor,
    RouteTransitionsBuilder transitionsBuilder,
    Gravity gravity,
    bool gravityAnimationEnable,
    Function animatedFunc,
    bool barrierDismissible,
  })  : _child = child,
        _context = context,
        _gravity = gravity,
        _gravityAnimationEnable = gravityAnimationEnable,
        _duration = duration,
        _barrierColor = barrierColor,
        _animatedFunc = animatedFunc,
        _transitionsBuilder = transitionsBuilder,
        _barrierDismissible = barrierDismissible {
    this.show();
  }

  show() {
    //fix transparent error
    if (_barrierColor == Colors.transparent) {
      _barrierColor = Colors.white.withOpacity(0.0);
    }

    showGeneralDialog(
      context: _context,
      barrierColor: _barrierColor ?? Colors.black.withOpacity(.3),
      barrierDismissible: _barrierDismissible ?? true,
      barrierLabel: "",
      transitionDuration: _duration ?? Duration(milliseconds: 250),
      transitionBuilder: _transitionsBuilder ?? _buildMaterialDialogTransitions,
      pageBuilder: (BuildContext buildContext, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        return Builder(
          builder: (BuildContext context) {
            return WillPopScope(
                onWillPop: () async {
                  return Future.value(_barrierDismissible);
                },
                child: _child);
          },
        );
      },
    );
  }

  Widget _buildMaterialDialogTransitions(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    Animation<Offset> custom;
    switch (_gravity) {
      case Gravity.center:
      default:
        custom = Tween<Offset>(
          begin: Offset(0.0, 0.0),
          end: Offset(0.0, 0.0),
        ).animate(animation);
        break;
    }

    //自定义动画
    if (_animatedFunc != null) {
      return _animatedFunc(child, animation);
    }

    //不需要默认动画
    if (!_gravityAnimationEnable) {
      custom = Tween<Offset>(
        begin: Offset(0.0, 0.0),
        end: Offset(0.0, 0.0),
      ).animate(animation);
    }

    return SlideTransition(
      position: custom,
      child: child,
    );
  }
}

//================================弹窗重心======================================
enum Gravity {
  left,
  top,
  bottom,
  right,
  center,
  rightTop,
  leftTop,
  rightBottom,
  leftBottom,
}
//============================================================================
