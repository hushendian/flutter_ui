import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'basis.dart';
import 'bot_toast_init.dart';
import 'key_board_safe_area.dart';
import 'animation.dart';
import 'toast_widget.dart';

void safeRun(void Function() callback) {
  SchedulerBinding.instance.addPostFrameCallback((_) {
    callback();
  });
  SchedulerBinding.instance.ensureVisualUpdate();
}

///[ToastBuilder]方法生成widget时,请确保生成的Widget背景不会吸收点击事件
///例如[Scaffold],[Material]都会默认占满整个父空间,
///并且会吸收事件(就算透明也是这种情况),具体例子可看[material.dart->_RenderInkFeatures class->hitTestSelf method]
///如果真的要生成,可以考虑使用[IgnorePointer].
///如果没有遵守规则,将会时某些功能失效例如[allowClick]功能就会失效
class ToastUtil {
  static const String textKey = '_textKey';
  static const String notificationKey = '_notificationKey';
  static const String loadKey = '_loadKey';
  static const String attachedKey = '_attachedKey';
  static const String defaultKey = '_defaultKey';

  static final Map<String, List<CancelFunc>> cacheCancelFunc = {
    textKey: [],
    notificationKey: [],
    loadKey: [],
    attachedKey: [],
    defaultKey: [],
  };

  ///显示一个标准文本Toast
  ///
  ///[text] 需要显示的文本
  ///[contentColor] ToastContent区域背景颜色
  ///[borderRadius] ToastContent区域圆角
  ///[textStyle] 字体样式
  ///[contentPadding] ToastContent区域的内补
  ///[align] ToastContent区域在MainContent区域的对齐
  ///[wrapAnimation] 请看[showAnimationWidget.wrapAnimation],默认值为null
  ///[wrapToastAnimation] 请看[showAnimationWidget.wrapToastAnimation],默认值为[textAnimation]
  ///[animationDuration] 请看[showAnimationWidget.animationDuration]
  ///[animationReverseDuration] 请看[showAnimationWidget.animationReverseDuration]
  ///[backgroundColor] 请看[showEnhancedWidget.backgroundColor]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[onlyOne] 请看[showEnhancedWidget.onlyOne]
  ///[clickClose] 请看[showEnhancedWidget.clickClose]
  ///[crossPage] 请看[showEnhancedWidget.crossPage]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  static CancelFunc showText(
      {@required String text,
      WrapAnimation wrapAnimation,
      WrapAnimation wrapToastAnimation = textAnimation,
      Color contentColor = Colors.black54,
      BorderRadiusGeometry borderRadius =
          const BorderRadius.all(Radius.circular(8)),
      TextStyle textStyle = const TextStyle(fontSize: 17, color: Colors.white),
      AlignmentGeometry align = const Alignment(0, 0),
      EdgeInsetsGeometry contentPadding =
          const EdgeInsets.only(left: 14, right: 14, top: 5, bottom: 7),
      Duration duration = const Duration(seconds: 2),
      Duration animationDuration,
      Duration animationReverseDuration}) {
    return showCustomText(
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: wrapToastAnimation,
        duration: duration,
        animationDuration: animationDuration,
        animationReverseDuration: animationReverseDuration,
        align: align,
        toastBuilder: (_) => TextToast(
              contentPadding: contentPadding,
              contentColor: contentColor,
              borderRadius: borderRadius,
              textStyle: textStyle,
              text: text,
            ));
  }

  ///显示一个自定义的文本Toast
  ///
  ///[toastBuilder] 生成需要显示的Widget的builder函数
  ///[align] ToastContent区域在MainContent区域的对齐
  ///[wrapAnimation] 请看[showAnimationWidget.wrapAnimation],默认值为null
  ///[wrapToastAnimation] 请看[showAnimationWidget.wrapToastAnimation],默认值为[textAnimation]
  ///[animationDuration] 请看[showAnimationWidget.animationDuration]
  ///[animationReverseDuration] 请看[showAnimationWidget.animationReverseDuration]
  ///[ignoreContentClick] 请看[showEnhancedWidget.ignoreContentClick]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[onlyOne] 请看[showEnhancedWidget.onlyOne]
  ///[clickClose] 请看[showEnhancedWidget.clickClose]
  ///[crossPage] 请看[showEnhancedWidget.crossPage]
  ///[backgroundColor] 请看[showEnhancedWidget.backgroundColor]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  static CancelFunc showCustomText(
      {@required ToastBuilder toastBuilder,
      WrapAnimation wrapAnimation,
      WrapAnimation wrapToastAnimation = textAnimation,
      Alignment align = const Alignment(0, 0.8),
      Color backgroundColor = Colors.transparent,
      Duration duration = const Duration(seconds: 2),
      Duration animationDuration,
      Duration animationReverseDuration}) {
    return showAnimationWidget(
        groupKey: textKey,
        duration: duration,
        animationDuration:
            animationDuration ?? const Duration(milliseconds: 256),
        animationReverseDuration: animationReverseDuration,
        wrapAnimation: wrapAnimation,
        wrapToastAnimation: (controller, cancel, child) {
          if (wrapToastAnimation != null) {
            child = wrapToastAnimation(controller, cancel, child);
          }
          if (align != null) {
            child = Align(alignment: align, child: child);
          }
          return SafeArea(child: child);
        },
        toastBuilder: toastBuilder);
  }

  ///显示一个使用了Animation的Toast
  ///使用请看:
  ///[ToastUtil.showCustomNotification]
  ///[ToastUtil.showCustomText]
  ///[ToastUtil.showCustomLoading]
  ///[ToastUtil.showAttachedWidget]
  ///
  ///[toastBuilder] 生成需要显示的Widget的builder函数
  ///[animationDuration] 正向动画的持续时间,其含义等同于[AnimationController.duration],值得注意的是建议不要超过[duration]
  ///[animationReverseDuration] 反向动画的持续时间,其含义等同于[AnimationController.reverseDuration]
  ///
  ///[wrapAnimation] 包装MainContent区域的动画,可用于自定义动画,如果为null则表示不需要动画,
  ///使用这个函数不意味着一定要使用动画,可以额外做一些包装widget的处理
  ///
  ///[wrapToastAnimation] 包装ToastContent区域的动画,可用于自定义动画,如果为null则表示不需要动画,
  ///使用这个函数不意味着一定要使用动画,可以额外做一些包装widget的处理
  ///
  ///[key] 请看[showEnhancedWidget.key]
  ///[groupKey] 请看[showEnhancedWidget.groupKey]
  ///[crossPage] 请看[showEnhancedWidget.crossPage]
  ///[allowClick] 请看[showEnhancedWidget.allowClick]
  ///[clickClose] 请看[showEnhancedWidget.clickClose]
  ///[ignoreContentClick] 请看[showEnhancedWidget.ignoreContentClick]
  ///[onlyOne] 请看[showEnhancedWidget.onlyOne]
  ///[backgroundColor] 请看[showEnhancedWidget.backgroundColor]
  ///[duration] 请看[showEnhancedWidget.duration]
  ///[onClose] 请看[showEnhancedWidget.onClose]
  static CancelFunc showAnimationWidget({
    @required ToastBuilder toastBuilder,
    @required Duration animationDuration,
    Duration animationReverseDuration,
    WrapAnimation wrapAnimation,
    WrapAnimation wrapToastAnimation,
    UniqueKey key,
    String groupKey,
    Duration duration,
    VoidCallback onClose,
  }) {
    assert(toastBuilder != null);
    assert(animationDuration != null);

    AnimationController controller = _createAnimationController(
        animationDuration,
        reverseDuration: animationReverseDuration);

    return showEnhancedWidget(
        groupKey: groupKey,
        key: key,
        closeFunc: () => controller?.reverse(),
        duration: duration,
        warpWidget: (cancel, child) => ProxyInitState(
              initStateCallback: () {
                assert(!controller.isAnimating);
                controller.forward();
              },
              child: ProxyDispose(
                  disposeCallback: () {
                    controller.dispose();
                    controller = null;
                  },
                  child: wrapAnimation != null
                      ? wrapAnimation(controller, cancel, child)
                      : child),
            ),
        toastBuilder: (cancelFunc) => wrapToastAnimation != null
            ? wrapToastAnimation(
                controller, cancelFunc, toastBuilder(cancelFunc))
            : toastBuilder(cancelFunc));
  }

  ///显示一个增强Toast,该方法可以让Toast自带很多特性,例如定时关闭,点击屏幕自动关闭,离开当前Route关闭等等
  ///核心方法,详情使用请看:
  ///[ToastUtil.showAnimationWidget]
  ///
  ///[toastBuilder] 生成需要显示的Widget的builder函数
  ///[key] 代表此Toast的一个凭证,凭此key可以删除当前key所定义的Widget,[remove]
  ///[groupKey] 代表分组的key,主要用于[removeAll]和[remove]
  ///
  ///[crossPage] 跨页面显示,如果为true,则该Toast会跨越多个Route显示,
  ///如果为false则在当前Route发生变化时,会自动关闭该Toast,例如[Navigator.push]-[Navigator.pop]
  ///
  ///[allowClick] 是否在该Toast显示时,能否正常点击触发事件
  ///[clickClose] 是否在点击屏幕触发事件时自动关闭该Toast
  ///
  ///[ignoreContentClick] 是否忽视ToastContext区域
  ///这个参数如果为true时,用户点击该ToastContext区域时,用户可以的点击事件可以正常到达到Page上
  ///换一句话说就是透明的(即便是Toast背景颜色不是透明),如果为false,则情况反之
  ///
  ///[onlyOne] 表示是否该分组内是否在同一时间里只存在一个Toast,区分是哪一个组是按照[groupKey]来区分的
  ///
  ///[closeFunc] 该函数参数主要目的使Toast关闭之做一些处理例如
  ///触发关闭前调用[AnimationController]来启动并等待动画后再关闭
  ///
  ///[backgroundColor]  MainContent区域的背景颜色
  ///[warpWidget] 一个wrap函数,可以用来warp MainContent区域,例如[showCustomLoading]就包裹了一个动画
  ///让MainContent区域也具有动画
  ///
  ///[duration] 持续时间,如果为null则不会去定时关闭,如果不为null则在到达指定时间时自动关闭
  ///[onClose] Toast关闭时调用
  static CancelFunc showEnhancedWidget(
      {@required ToastBuilder toastBuilder,
      UniqueKey key,
      String groupKey,
      FutureFunc closeFunc,
      WrapWidget warpWidget,
      Duration duration}) {
    assert(toastBuilder != null);

    //由于cancelFunc一开始是为空的,所以在赋值之前需要在闭包里使用
    CancelFunc cancelFunc;
    CancelFunc dismissFunc = () async {
      await closeFunc?.call();
      cancelFunc();
    };

    //onlyOne 功能
    final List<CancelFunc> cache =
        (cacheCancelFunc[groupKey ?? defaultKey] ??= []);
    final clone = cache.toList();
    cache.clear();
    clone.forEach((cancel) {
      cancel();
    });
    cache.add(dismissFunc);

    //定时功能
    Timer timer;
    if (duration != null) {
      timer = Timer(duration, () {
        dismissFunc();
        timer = null;
      });
    }

    cancelFunc = showWidget(
        groupKey: groupKey,
        key: key,
        toastBuilder: (_) {
          return KeyBoardSafeArea(
            child: ProxyDispose(disposeCallback: () {
              cache.remove(dismissFunc);
              timer?.cancel();
            }, child: Builder(builder: (BuildContext context) {
              TextStyle textStyle = Theme.of(context).textTheme.body1;
              Widget child = DefaultTextStyle(
                style: textStyle,
                child: toastBuilder(dismissFunc),
              );
              return warpWidget != null
                  ? warpWidget(dismissFunc, child)
                  : child;
            })),
          );
        });

    return dismissFunc;
  }

  ///显示一个Widget在屏幕上,该Widget可以跨多个页面存在
  ///
  ///[toastBuilder] 生成需要显示的Widget的builder函数
  ///[key] 代表此Toast的一个凭证,凭此key可以删除当前key所定义的Widget,[remove]
  ///[groupKey] 代表分组的key,主要用于[removeAll]和[remove]
  ///[CancelFunc] 关闭函数,主动调用将会关闭此Toast
  ///这是个核心方法
  static CancelFunc showWidget(
      {@required ToastBuilder toastBuilder, UniqueKey key, String groupKey}) {
    assert(toastBuilder != null);
    final gk = groupKey ?? defaultKey;
    final uniqueKey = key ?? UniqueKey();
    final CancelFunc cancelFunc = () {
      remove(uniqueKey, gk);
    };

    botToastManager.insert(gk, uniqueKey, toastBuilder(cancelFunc));
    return cancelFunc;
  }

  static void remove(UniqueKey key, [String groupKey]) {
    botToastManager.remove(groupKey ?? defaultKey, key);
  }

  static void removeAll([String groupKey]) {
    botToastManager.removeAll(groupKey ?? defaultKey);
  }

  static void cleanAll() {
    botToastManager.cleanAll();
  }

  static AnimationController _createAnimationController(Duration duration,
      {Duration reverseDuration}) {
    assert(duration != null);
    return AnimationController(
        vsync: TickerProviderImpl(),
        duration: duration,
        reverseDuration: reverseDuration);
  }
}
