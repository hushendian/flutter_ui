import 'package:flutter/material.dart';
import 'GradientButton.dart';

class GradientButtonRoute extends StatefulWidget {
  @override
  _GradientButtonRouteState createState() => _GradientButtonRouteState();
}

class _GradientButtonRouteState extends State<GradientButtonRoute> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GradientButton(
              colors: [Color(0xffFFE251), Color(0xffFDD108)],
              height: 60.0,
              width: 100,
              textColor: Colors.red,
              textSize: 10,
              radius: BorderRadius.circular(5),
              text: "上",
              position: Position.TOP.index,
              imagePath: "images/icons/icon_man.png",
              imageHeight: 20,
              imageWidth: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GradientButton(
              colors: [Color(0xffFFE251), Color(0xffFDD108)],
              height: 60.0,
              width: 100,
              textColor: Colors.red,
              textSize: 10,
              radius: BorderRadius.circular(5),
              text: "生",
              position: Position.BOTTOM.index,
              imagePath: "images/icons/icon_man.png",
              imageWidth: 20,
              imageHeight: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GradientButton(
              colors: [Color(0xffFFE251), Color(0xffFDD108)],
              height: 50.0,
              width: 100,
              textColor: Colors.red,
              textSize: 20,
              radius: BorderRadius.circular(5),
              text: "左",
              position: Position.LEFT.index,
              imagePath: "images/icons/icon_man.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GradientButton(
              colors: [Color(0xffFFE251), Color(0xffFDD108)],
              height: 50.0,
              width: 100,
              textColor: Colors.red,
              textSize: 20,
              radius: BorderRadius.circular(5),
              text: "右",
              position: Position.RIGHT.index,
              imagePath: "images/icons/icon_man.png",
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GradientButton(
              colors: [Color(0xffFFE251), Color(0xffFDD108)],
              height: 50.0,
              width: 100,
              textColor: Colors.red,
              textSize: 20,
              radius: BorderRadius.circular(5),
              text: "正常",
              onTap: (){
                print("00000");
              },
            ),
          ),
        ],
      ),
    );
  }

  onTap() {
    print("button click");
  }
}
