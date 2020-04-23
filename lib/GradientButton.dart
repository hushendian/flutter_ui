import 'package:flutter/material.dart';

enum Position { TOP, BOTTOM, LEFT, RIGHT }

class GradientButton extends StatelessWidget {
  final List<Color> colors; //渐变色色值
  final double width; //按钮宽度
  final double height; //按钮高度
  final Color textColor; //按钮字体色值
  final double textSize; //按钮字体大小
  final BorderRadius radius; //按钮圆角
  final String imagePath; //按钮图标
  final double imageWidth; //按钮图标宽度
  final double imageHeight; //按钮图标高度
  final double marge; //图标与文字间距
  final String text; //文字
  int position = -1; //图标位置
  final Border border; //边框
  double _marge;
  VoidCallback onTap;

  GradientButton(
      {this.colors,
      this.width,
      this.height,
      this.textColor,
      this.textSize,
      this.radius,
      this.position,
      this.imagePath,
      this.imageWidth,
      this.imageHeight,
      this.marge,
      this.border,
      @required this.text,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    List<Color> _colors = colors ?? [Color(0xFFE251), Color(0xFDD108)];
    _marge = marge ?? 2;
    Border _border = border ?? Border.all(color: Colors.transparent, width: 1);
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: DecoratedBox(
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: _colors),
            borderRadius: radius,
            border: _border),
        child: ConstrainedBox(
          constraints: BoxConstraints.tightFor(width: width, height: height),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: DefaultTextStyle(
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: textSize,
                    color: textColor),
                child: _buildButtonWidget(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonWidget() {
    if (Position.LEFT.index == position) {
      return _buildLeftImageButton();
    } else if (Position.RIGHT.index == position) {
      return _buildRightImageButton();
    } else if (Position.TOP.index == position) {
      return _buildTopImageButton();
    } else if (Position.BOTTOM.index == position) {
      return _buildBottomImageButton();
    } else {
      return _buildButtonNoImage();
    }
  }

  Widget _buildLeftImageButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, _marge, 0),
          child: Image.asset(
            imagePath,
            height: imageHeight,
            width: imageWidth,
          ),
        ),
        Text(text)
      ],
    );
  }

  Widget _buildRightImageButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text),
        Padding(
          padding: EdgeInsets.fromLTRB(_marge, 0, 0, 0),
          child: Image.asset(
            imagePath,
            height: imageHeight,
            width: imageWidth,
          ),
        ),
      ],
    );
  }

  Widget _buildTopImageButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, _marge),
          child: Image.asset(
            imagePath,
            height: imageHeight,
            width: imageWidth,
          ),
        ),
        Text(text)
      ],
    );
  }

  Widget _buildBottomImageButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(text),
        Padding(
          padding: EdgeInsets.fromLTRB(0, _marge, 0, 0),
          child: Image.asset(
            imagePath,
            height: imageHeight,
            width: imageWidth,
          ),
        ),
      ],
    );
  }

  Widget _buildButtonNoImage() {
    return Text(text);
  }
}
