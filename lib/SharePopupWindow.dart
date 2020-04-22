import 'package:flutter/material.dart';
import 'package:flutter_app/ItemBean.dart';

class SharePopupWindow extends StatelessWidget {
  final List<ItemBean> list; //数据源
  final double windowHeight; //弹框高度
  final double contentHeight; //可滚动高度
  final bool isSingleRow; //是否多列
  final OnItemClickListener callBack; //回调
  static BuildContext mContext;

  SharePopupWindow(
      {@required this.list,
      this.windowHeight,
      this.contentHeight,
      this.isSingleRow,
      this.callBack});

/*创建bottomSheet*/
  static void showBottomSheet(
      BuildContext context,
      List<ItemBean> list,
      OnItemClickListener listener,
      bool isSingleRow,
      double windowHeight,
      double contentHeight) {
    mContext = context;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return Stack(
            children: <Widget>[
              Container(
                height: 30.0,
                width: double.infinity,
                color: Colors.black54,
              ),
              Container(
                height: windowHeight ?? 250,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    )),
              ),
              SharePopupWindow(
                list: list,
                callBack: listener,
                isSingleRow: isSingleRow,
                windowHeight: windowHeight,
                contentHeight: contentHeight,
              ),
            ],
          );
        });
  }

  closeBottomSheet(BuildContext context) {
    print("关闭");
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return _buildWidget();
  }

  Widget _buildWidget() {
    var _defaultWindowHeight = windowHeight ?? 250.0;
    var _defaultContentHeight = contentHeight ?? 190.0;
    var _isSingleRow = isSingleRow ?? true;
    if (_isSingleRow) {
      return _takePhotoWidget(_defaultWindowHeight, _defaultContentHeight);
    } else {
      return _shareWidget(_defaultWindowHeight, _defaultContentHeight);
    }
  }

/*分享朋友圈布局*/
  Widget _shareWidget(double windowHeight, double contentHeight) {
    return new Container(
      height: windowHeight,
      child: new Column(
        children: <Widget>[
          new Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: new Container(
              height: contentHeight,
              child: new GridView.builder(
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 5.0,
                    childAspectRatio: 1.0),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      callBack.onItemClick(index);
                    },
                    child: new Column(
                      children: <Widget>[
                        new Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 6.0, 0.0, 6.0),
                            child: new Image.asset(
                              '${list[index].icon}',
                              width: 50.0,
                              height: 50.0,
                              fit: BoxFit.fill,
                            )),
                        new Text(list[index].title)
                      ],
                    ),
                  );
                },
                itemCount: list.length,
              ),
            ),
          ),
          new Container(
            height: 0.5,
            color: Color(0xffeaeaea),
          ),
          GestureDetector(
            onTap: () {
              closeBottomSheet(mContext);
            },
            child: new Center(
              child: new Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child: new Text(
                    '取消',
                    style:
                        new TextStyle(fontSize: 18.0, color: Color(0xff636B73)),
                  )),
            ),
          )
        ],
      ),
    );
  }

/*拍照布局*/
  Widget _takePhotoWidget(double windowHeight, double contentHeight) {
    return new Container(
      height: windowHeight,
      child: new Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
            height: contentHeight,
            child: new ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    callBack.onItemClick(index);
                  },
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            list[index].title,
                            style: TextStyle(
                              color: Color(0xff636B73),
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                          height: 0.5,
                          color: Color(0xffeaeaea),
                        )
                      ],
                    ),
                  ),
                );
              },
              itemCount: list.length,
            ),
          ),
          new Container(
            height: 10,
            color: Color(0xffeaeaea),
          ),
          GestureDetector(
            onTap: () {
              closeBottomSheet(mContext);
            },
            child: new Center(
              child: new Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 8.0),
                  child: new Text(
                    '取消',
                    style:
                        new TextStyle(fontSize: 18.0, color: Color(0xff636B73)),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

abstract class OnItemClickListener {
  void onItemClick(int index);
}
