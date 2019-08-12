
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FSMessageHeader extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _FSMessageHeaderState();
  }
}

class _FSMessageHeaderState extends State<FSMessageHeader> {

  bool isShowTip = true;

  @override
  Widget build(BuildContext context) {
    return buildBody();
  }
  
  Widget buildBody() {
    if (isShowTip) {
      return Column(
        children: <Widget>[
          buildCategoryWidget(),
          buildNotificationTip(),
        ],
      );
    } else {
      return buildCategoryWidget();
    }
  }

  Widget buildCategoryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: <Widget>[
          // bottom yellow
          Container(
            height: 64,
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)
              )
            ),
          ),

          // grid
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: buildGrid(),
          ),
        ],
      )
    ); 
  }

  Widget buildGrid() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(14)),
        // boxShadow:[
        //   BoxShadow(
        //     color: Colors.black12,
        //     offset: Offset(1, 10),
        //     blurRadius: 10,
        //   )
        // ] 
      ),
      child: GridView(
        shrinkWrap: true, // 收缩，只占用他需要的大小，而不是占满全屏
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        children:[
          buildGridItem("https://cataas.com/cat", 2, "通知消息", false),
          buildGridItem("https://cataas.com/cat", 0, "互动消息", false),
          buildGridItem("https://cataas.com/cat", 0, "活动消息", true),
          buildGridItem("https://cataas.com/cat", 0, "鱼塘消息", false),
        ]
      ),
    );
  }

  Widget buildGridItem(String image, int count, String title, bool showPoint) {
    return Container(
      child: Column(
        children: <Widget>[
          buildGridImage(image, count, showPoint),
          
          SizedBox(
            height: 6,
          ),

          Text(
            title,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 13
            ),
          ),
        ],
      ),
    );
  }

  Widget buildGridImage(String image, int count, bool showPoint) {
    double circleR = 20;
    List<Widget> _list = [];
   
    // pic 
    _list.add(
      CircleAvatar(
        radius: 25,
        backgroundImage: CachedNetworkImageProvider(image),
      ),
    );

    // badge
    if (showPoint || count != 0) {
      if (showPoint) {
        circleR = 14;
      }

      _list.add(
        Align(
          alignment: Alignment.topRight,
          child: Container(
            width: circleR,
            height: circleR,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(circleR/2),
              border: Border.all(color: Colors.white, width: 2)
            ),
            child: Center(
              child: Text(
                count == 0 ? "" : "$count",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10
                ),
              ),
            )
          )
        )
      );
    }

    return Container(
      width: 50,
      height: 50,
      child: Stack(
        alignment: Alignment.center,
        children: _list
      ),
    );
  }

  Widget buildNotificationTip() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 14, 10, 10),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage("images/image_01.png"),
            fit: BoxFit.cover
          )
        ),
        child: Row(
          children: <Widget>[
            // clost 
            Padding(
              padding: EdgeInsets.fromLTRB(5, 5, 0, 30),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isShowTip = false;
                  });
                },
                child: 
                Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: Icon(
                    Icons.close,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              )
            ),
            
            Container(
              width: 240,
              padding: EdgeInsets.only(left: 54, right: 5),
              child: Text(
                "开启通知，不错过任何一次可能成交的机会!",
                //"开启通知",
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),

            // button 
            Padding(
              padding: EdgeInsets.only(right: 0),
              child: Container(
                height: 30,
                width: 100,
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white
                ),
                child: Text(
                  "立即开启",
                  style: TextStyle(
                    color: Colors.red[400],
                    fontSize: 13
                  ),
                ),
              ),
            ),
          ],
        ),        
      )
    );
  }
}
