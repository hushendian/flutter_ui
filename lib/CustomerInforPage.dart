import 'package:flutter/material.dart';

//客户信息页面
class CustomerInfoPage extends StatefulWidget {
  @override
  _CustomerInfoPageState createState() => _CustomerInfoPageState();
}

class _CustomerInfoPageState extends State<CustomerInfoPage> {
  /*基本信息*/
  Widget _buildBasicInfoWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              "基本信息",
              style: TextStyle(
                  color: Color(0xff2b2b2b),
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            _buildParentNameWidget(),
            _buildWXNameWidget(),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Text(
                "北京市东城区西直门12号",
                style: TextStyle(color: Color(0xff777777), fontSize: 12),
              ),
            ),
            _buildStudentItemWidget(),
            Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Divider(
                height: 1,
                color: Color(0xffEDEDED),
              ),
            ),
            _buildAddStudentWidget()
          ]),
    );
  }

  /*家长姓名*/
  Widget _buildParentNameWidget() {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 15, 0, 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text("家长姓名",
              style: TextStyle(color: Color(0xff2b2b2b), fontSize: 16)),
          Container(
            margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
            child: Text(
              "刘女士",
              style: TextStyle(
                  color: Color(0xff2b2b2b),
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
          ),
          Image(
            image: AssetImage("images/icons/icon_copy.png"),
            width: 15,
            height: 15,
          ),
          Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.centerRight,
                child: Image(
                  image: AssetImage("images/icons/icon_arrow.png"),
                  width: 20,
                  height: 20,
                ),
              ))
        ],
      ),
    );
  }

  /*家长微信名称*/
  Widget _buildWXNameWidget() {
    return Row(
      children: <Widget>[
        Text("微信昵称", style: TextStyle(color: Color(0xff2b2b2b), fontSize: 16)),
        Container(
          margin: EdgeInsets.fromLTRB(5, 0, 10, 0),
          child: Text(
            "小猪佩奇",
            style: TextStyle(
                color: Color(0xff2b2b2b),
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
        ),
        Image(
          image: AssetImage("images/icons/icon_copy.png"),
          width: 15,
          height: 15,
        )
      ],
    );
  }

  /*学员信息*/
  Widget _buildStudentItemWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
          child: Divider(
            height: 1,
            color: Color(0xffEDEDED),
          ),
        ),
        /*学员姓名*/
        Row(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: Text("学员姓名",
                  style: TextStyle(fontSize: 16, color: Color(0xff2b2b2b))),
            ),
            Text("张三",
                style: TextStyle(
                    fontSize: 16,
                    color: Color(0xff2b2b2b),
                    fontWeight: FontWeight.bold)),
            Expanded(
                flex: 1,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Image(
                    image: AssetImage("images/icons/icon_arrow.png"),
                    width: 20,
                    height: 20,
                  ),
                )),
          ],
        ),
        /*消课信息，请假信息，体测记录*/
        Row(
          children: <Widget>[
            _buildButtonWidget("消课记录"),
            _buildButtonWidget("请假记录"),
            _buildButtonWidget("体测记录"),
          ],
        ),
        Container(
          child: Text(
            "13岁是男是女上课时能看到你上课丹尼斯克丹尼斯克电脑是能看到你上课的那是你的事看上",
            style: TextStyle(fontSize: 12, color: Color(0xff777777)),
          ),
        )
      ],
    );
  }

  Widget _buildButtonWidget(String content) {
    return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 10, 10),
      height: 25,
      child: RaisedButton(
        child: Text(
          content,
          style: TextStyle(fontSize: 12, color: Color(0xff3E3A39)),
        ),
        color: Color(0xd2FDD108),
        shape: RoundedRectangleBorder(
            side: BorderSide(color: Color(0xffFDD108), width: 1),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: () => {},
      ),
    );
  }

/*添加学员*/
  Widget _buildAddStudentWidget() {
    return Container(
      alignment: Alignment.center,
      child: Text(
        "添加学员+",
        style: TextStyle(color: Color(0xff1b1b1b), fontSize: 12),
      ),
    );
  }

  /*成单技巧*/
  Widget _buildOrderMethod() {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        children: <Widget>[
          Text("成单技巧",
              style: TextStyle(
                  color: Color(0xff2b2b2b),
                  fontWeight: FontWeight.bold,
                  fontSize: 18))
        ],
      ),
    );
  }

  /*销售记录*/
  Widget _buildSaleRecordWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("销售记录",
              style: TextStyle(
                  color: Color(0xff2b2b2b),
                  fontWeight: FontWeight.bold,
                  fontSize: 18)),
          _buildSaleItemWidget()
        ],
      ),
    );
  }

  /*销售记录Item*/

  Widget _buildSaleItemWidget() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          /*销售姓名及公司*/
          Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                child: Text(
                  "销售-张三",
                  style: TextStyle(fontSize: 12, color: Color(0xff2b2b2b)),
                ),
              ),
              Text(
                "北京分公司",
                style: TextStyle(fontSize: 12, color: Color(0xffbdbdbd)),
              ),
              Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      "销售-张三",
                      style: TextStyle(fontSize: 12, color: Color(0xff2b2b2b)),
                    ),
                  ))
            ],
          ),
          Text(
            "有钱人能让你男人嫩让你",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff2b2b2b)),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text("2020-01-20 15:12",
                  style: TextStyle(fontSize: 12, color: Color(0xffbdbdbd))),
            ),
          ),
          Divider(
            height: 1,
            color: Color(0xffEDEDED),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _buildBasicInfoWidget(),
          _buildOrderMethod(),
          _buildSaleRecordWidget()
        ],
      ),
    );
  }
}
