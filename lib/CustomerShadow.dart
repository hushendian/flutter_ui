import 'package:flutter/material.dart';

/*阴影背景*/
class CustomerShadow extends StatelessWidget {
  final BorderRadius radius; //背景圆角
  final Color boxShadowColor; //阴影色
  final double blurRadius; //延伸距离会有模糊效果
  final double spreadRadius; //延伸距离不会有模糊效果
  final Widget child;

  CustomerShadow(
      {this.radius,
      this.boxShadowColor,
      this.blurRadius,
      this.spreadRadius,
      this.child});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: [
          //BoxShadow中Offset (1,1)右下，(-1,-1)左上,(1,-1)右上,(-1,1)左下
          _buildBoxShadow(Offset(-1, 1)),
          _buildBoxShadow(Offset(1, 1)),
          _buildBoxShadow(Offset(1, -1)),
          _buildBoxShadow(Offset(-1, -1))
        ],
      ),
      child: child,
    );
  }

  BoxShadow _buildBoxShadow(Offset offset) {
    var _blurRadius = blurRadius ?? 0;
    if (_blurRadius > 0) {
      return BoxShadow(
        color: boxShadowColor,
        offset: offset,
        blurRadius: blurRadius,
      );
    } else {
      return BoxShadow(
        color: boxShadowColor,
        offset: offset,
        spreadRadius: spreadRadius,
      );
    }
  }
}
