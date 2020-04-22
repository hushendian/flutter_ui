import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

///Toast的关闭函数,调用将会提前关闭对应的Toast
typedef CancelFunc = void Function();
typedef ToastBuilder = Widget Function(CancelFunc cancelFunc);
typedef FutureFunc = Future Function();

typedef WrapWidget = Widget Function(CancelFunc cancelFunc, Widget widget);
typedef WrapAnimation = Widget Function(AnimationController controller, CancelFunc cancelFunc, Widget widget);

class TickerProviderImpl extends TickerProvider {
  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}

//请不要调整顺序!!
//前面是主方向,后面是对齐比如
//topLeft,就是希望在上面,并且左对齐目标
enum PreferDirection {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
  leftTop,
  leftCenter,
  leftBottom,
  rightTop,
  rightCenter,
  rightBottom,
}
