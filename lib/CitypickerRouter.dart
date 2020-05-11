import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/citypicker/city_pickers.dart';

import 'province.dart';
import 'provinceBean.dart';

class CitypickerRouter extends StatefulWidget {
  @override
  _CitypickerRouter createState() => _CitypickerRouter();
}

class _CitypickerRouter extends State<CitypickerRouter> {
  double barrierOpacityAttr = 0.5;
  bool barrierDismissibleAttr = false;
  bool customerMeta = false;
  bool customerItemBuilder = false;
  double customerItemExtent = 40;
  bool customerButtons = false;
  Result result = new Result();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter",
      home: Scaffold(
        body: Padding(
            padding: EdgeInsets.fromLTRB(10, 40, 10, 0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    onPressed: () async {
                      List parsedJson = json.decode(provinceData);
                      List provinceList = new List<String>();
                      List cityList = new List<List<String>>();

                      List areaList = new List<List<String>>();
                      parsedJson.forEach((v) {
                        provinceList.add(provinceBean.fromJson(v).province);
                        List city = new List<String>();
                        provinceBean.fromJson(v).citys.forEach((v1) {
                          areaList.add(v1.areas);
                          city.add(v1.cityName);
                        });
                        cityList.add(city);
                      });
                      Result tempResult = await CityPickers.showCityPicker(
                          context: context,
                          title: "title",
                          provinceList: provinceList,
                          cityList: cityList,
                          areas: areaList,
                          barrierOpacity: barrierOpacityAttr,
                          barrierDismissible: barrierDismissibleAttr,
                          itemExtent: customerItemExtent,
                          cancelWidget: customerButtons ? Text('cancle') : null,
                          confirmWidget:
                              customerButtons ? Text('confirm') : null,
                          itemBuilder: this.getItemBuilder());
                      if (tempResult == null) {
                        return;
                      }
                      this.setState(() {
                        result = tempResult;
                      });
                    },
                    child: Text("展示city picker"),
                  ),
                  Center(
                    child: Text('$result'),
                  )
                ])),
      ),
    );
  }

  getItemBuilder() {
    if (customerItemBuilder) {
      return (item, list, index) {
        return Center(
            child: Text(item, maxLines: 1, style: TextStyle(fontSize: 55)));
      };
    } else {
      return null;
    }
  }
}
