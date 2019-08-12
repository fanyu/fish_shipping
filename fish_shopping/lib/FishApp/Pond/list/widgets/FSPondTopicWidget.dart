
import 'package:fish_shopping/utils/Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FSPondTopicWidget extends StatelessWidget {

  final List<String> _list = ["#厨神老爸再战江湖救急哈哈哈哈#", "#稀奇古怪手机大盘点那些#","#我的美容仪功课#",
    "#夏季宝宝这么穿#","#博物馆标本，精致的历史#","大家热议话题",];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildWrap(),
        _buildContent(),
        
        // separtor lines 
        Positioned(
          top: 110,
          left: Screen.width(context)/2,
          child: Container(
            width: 0.8,
            height: 146,
            color: Colors.grey[200],
          ),
        ),

        Positioned(
          top: 156,
          left: 20,
          child: Container(
            width: Screen.width(context) - 40,
            height: 0.8,
            color: Colors.grey[200],
          ),
        ),
        // 
        Positioned(
          top: 206,
          left: 20,
          child: Container(
            width: Screen.width(context) - 40,
            height: 0.8,
            color: Colors.grey[200],
          ),
        )
      ],
    );
  }

  Widget _buildWrap() {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(6),
          bottomRight: Radius.circular(6)
        )
      ),
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        height: 246,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            _buildImageWidget(),
            _buildGridWidget()
          ],
        ),
      ),
    );
  }

  Widget _buildImageWidget() {
    return Stack(
      children: <Widget>[
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10)
            ),
            color: Colors.white,
            image: DecorationImage(
              image: AssetImage("images/image_01.png"),
              fit: BoxFit.cover
            )
          ),
        ),
        Positioned(
          right: 10,
          top: 10,
          child: Text(
            "6.4万次浏览",
            style: TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w300
            )
          ),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Text(
            "#这才叫灌篮#",
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w500
            )
          ),
        ),
        Positioned(
          left: 10,
          top: 40,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.red
            ),
            child: Text(
              "热议话题",
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400
              )
            ),
          ),
        )
      ],
    );
  }

  Widget _buildGridWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(14, 8, 14, 10),
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          childAspectRatio: 6
        ),
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          var topic = _list[index];
          if (index == 2 || index == 3) {
            return _tagItem(topic, "热");
          } else if (index == _list.length - 1) {
            return _moreItem(topic, 3310);
          } else {
            return _normalItem(topic);
          }
        },
      ),
    );
  }

  Widget _normalItem(String topic) {
    return Container(
      alignment: Alignment.center,
      child: Text(
        topic,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )
    );
  }

  Widget _tagItem(String topic, String tag) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          topic,
          style: TextStyle(
            color: Colors.red[400],
            fontSize: 16,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: Colors.red[400]
          ),
          child: Text(
            tag,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14
            ),
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  Widget _moreItem(String topic, int count) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          topic,
          style: TextStyle(
            color: Colors.black,
            fontSize: 16
          ),
        ),
        
        Row(
          children: <Widget>[
            Text(
              "$count",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 14,
            )
          ],
        )
      ],
    );
  }

}