
import 'package:fish_shopping/utils/Screen.dart';
import 'package:flutter/material.dart';

class FSPostPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FSPostPageState();
  }
}

class _FSPostPageState extends State<FSPostPage> with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  
  AnimationController _rotateAnimation;
  Tween<double> _rotationTween;
  
  AnimationController _moveAnimation;
  Animation<EdgeInsets> movement;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _rotateAnimation = AnimationController(vsync: this, duration: Duration(seconds: 1));
    _rotationTween = Tween(begin: 0.2, end: 0.3);
    _rotationTween.animate(_rotateAnimation);
    //启动动画
    _rotateAnimation..forward();


    _moveAnimation = AnimationController(vsync: this, duration: Duration(microseconds: 1500));
    movement = EdgeInsetsTween(
      begin: EdgeInsets.only(top: 0.0),
      end: EdgeInsets.only(top: 100.0),
    ).animate(
      CurvedAnimation(
        parent: _moveAnimation,
        curve: Interval(
          0.2,
          0.375,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    _moveAnimation.forward();
    
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      child: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            buildTopWidget(),
            SizedBox(height: 350,),
            buildBottomWidget(),
            SizedBox(height: 80,),
            buildCloseButton(),
          ],
        )
      ),
    );
  }

  Widget buildCloseButton() {
    return RotationTransition(
      turns: _rotateAnimation,
      child: Icon(
        Icons.close,
        size: 40,
      ),
    );
  }

  Widget buildTopWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 100, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildTopItem(Icons.monetization_on, "淘宝转卖", Colors.red, Colors.red[50], "一键发布"),
          buildTopItem(Icons.shopping_basket, "免费送", Colors.orange, Colors.orange[50],"赚闲鱼币"),
          buildTopItem(Icons.crop_free, "扫码卖书", Colors.green, Colors.green[50], "图书换钱"),
        ],
      ),
    );
  }

  Widget buildTopItem(IconData icon, String title, Color titleColor, Color backColor, String detail) {
    return GestureDetector(
      onDoubleTap: () {

      },
      child: Container(
          width: (Screen.width(context) - 60 - 20) / 3,
          height: 50,
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: backColor,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Stack(
                    alignment: Alignment.center,
                    children: <Widget>[
                      Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: titleColor,
                          borderRadius: BorderRadius.circular(15)
                        ),
                      ),

                      Icon(
                        icon,
                        size: 15,
                        color: Colors.white,
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500
                    )
                  )
                ],
              ),
              
              Text(
                detail,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.normal
                )
              )
            ],
          ),
        ),
    );
  }

  Widget buildBottomWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 100, 0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          buildBottomItem(Icons.crop_square, "发布闲置", Colors.yellow[400], 0),
          buildBottomItem(Icons.flash_on, "信用回收", Colors.red[400], 0),
          buildBottomItem(Icons.home, "发布租房", Colors.blue[400], 0),
          buildBottomItem(Icons.edit, "发帖子", Colors.orange[400], 0),
        ],
      ),
    );
  }

  Widget buildBottomItem(IconData icon, String title, Color backColor, int index) {
    return GestureDetector(
      onTap: () {
        
      },
      child: Padding(
        padding: EdgeInsets.zero,
        child: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(35),
                    color: backColor
                  ),
                ),
                Icon(
                  icon,
                  size: 40,
                  color: Colors.white,
                )
              ],
            ),
            SizedBox(height: 10,),
            Text(
              title,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.normal
              ),
            )
          ],
        ),
      ),
    );
  }

}