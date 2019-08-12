
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// 定义block
typedef void SelectedMenuCallBack(String menu);

class FSMenuPage extends StatelessWidget {
  
  static show(BuildContext context, SelectedMenuCallBack callBack) {
    Navigator.of(context, rootNavigator: true).push(
       PageRouteBuilder( // 无动画的切换
        opaque: false,
        transitionDuration: Duration(seconds: 0),
        pageBuilder: (context, anim1, anim2) => FSMenuPage(callBack),
      ),
    );
  }

  FSMenuPage(this._menuCallBack);
  
  final SelectedMenuCallBack _menuCallBack;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Positioned(
              top: 100,
              left: 20,
              child: FSMenuAlert(selectedCallBack: (String menu) {
                _menuCallBack(menu);
                Navigator.of(context).pop(menu);
              }),
            ),
          ],
        )
      ),
    );
  }
}

class FSMenuAlert extends StatelessWidget {
  FSMenuAlert({
    Key key,
    this.selectedCallBack,
  }) : super(key: key);

  final SelectedMenuCallBack selectedCallBack;
  final double padding = 4.0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.black,
        clipBehavior: Clip.antiAlias,
        elevation: 0.0,
        shape: FSShapedBoarder(
          borderRadius: BorderRadius.all(Radius.circular(padding)), 
          padding: padding
        ),
        child: Container(
          color: Colors.black,
          padding: EdgeInsets.all(0),
          child: SizedBox(
            width: 90.0, 
            height: 144.0, 
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                buildAlertItem(Icons.shopping_basket, "宝贝"),
                Divider(color: Colors.white70),
                buildAlertItem(Icons.alarm_off, "鱼塘"),
                Divider(color: Colors.white70),
                buildAlertItem(Icons.person_outline, "用户"),
              ],
            )
          ),
        )
      ),
    );
  }

  Widget buildAlertItem(IconData iconData, String title) {
    return GestureDetector(
      onTap: () {
        selectedCallBack(title);
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.white,
              size: 20,
            ),

            SizedBox(
              width: 5,
            ),

            Text(
              title, 
              style: TextStyle(
                color: Colors.white,
                fontSize: 16
              ),
            )
          ],
        )
      )
    );
  }
}

class FSShapedBoarder extends RoundedRectangleBorder {
  FSShapedBoarder({
    @required this.padding,
    side = BorderSide.none,
    borderRadius = BorderRadius.zero
  }) : super(side: side, borderRadius: borderRadius);

  final double padding;

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return Path()
      ..moveTo(rect.center.dx - 6, rect.top)  
      ..lineTo(rect.center.dx, rect.top - 6)  // 顶点
      ..lineTo(rect.center.dx + 6, rect.top)
      ..addRRect(
        borderRadius
          .resolve(textDirection)
          .toRRect(Rect.fromLTWH(rect.left, rect.top, rect.width, rect.height - padding))
      );
  }
}


