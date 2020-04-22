import 'package:flutter/material.dart';
import 'CustomerShadow.dart';

class CustomerLabelRoute extends StatefulWidget {
  @override
  _CustomerLabelRoute createState() => _CustomerLabelRoute();
}

class _CustomerLabelRoute extends State<CustomerLabelRoute> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        child: CustomerShadow(
          boxShadowColor: Colors.grey[400],
          blurRadius: 5,
          child: _flatButton2(),
        ),
      ),
    );
  }
}

Widget _flatButton2() {
  return Container(
    decoration: BoxDecoration(),
    child: FlatButton(
        onPressed: () {},
        color: Colors.white,
        padding: EdgeInsets.only(left: 100, right: 100, top: 30, bottom: 30),
        child: Text(
          "分享",
          style: TextStyle(
            color: Colors.grey[400],
            fontSize: 10,
          ),
        )),
  );
}
