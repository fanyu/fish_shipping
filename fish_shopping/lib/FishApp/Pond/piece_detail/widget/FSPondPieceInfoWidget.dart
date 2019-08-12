
import 'package:fish_shopping/FishApp/Pond/list/model/FSPondPieceModel.dart';
import 'package:fish_shopping/utils/Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class FSPondPieceInfoWidget extends StatelessWidget {

  FSPondPieceInfoWidget(this.model);

  final FSPondPieceModel model;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
      sliver: SliverList(
        delegate: SliverChildListDelegate([
          _buildProfileWidget(),
          _buildContextWidget(),
          _buildPhotoWidget(context),
          _buildStatisticWidget(),
        ],)
      ),
    );
  }  

  Widget _buildProfileWidget() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(model.userAvatar),
            radius: 20,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.userName,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                  )
                ),
                Text(
                  "2天前来过",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12
                  )
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {

            },
            child: Container(
              height: 36,
              margin: EdgeInsets.fromLTRB(0, 12, 12, 10),
              padding: EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                border: Border.all(color: Colors.grey[300], width: 0.5)
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.add,
                    color: Colors.black,
                    size: 20
                  ),
                  Text(
                    "关注",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold
                    )
                  )
                ],
              ),
            ),
          )
        ],
      )
    );
  }

  Widget _buildContextWidget() {
    List<TextSpan> _children = [];

    if (model.topic != "") {
      _children.add(
        TextSpan(
          text: "${model.topic} ",
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.w300
          )
        ),
      );
    }

    _children.add(
      TextSpan(
        text: model.content,
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w300
        )
      )
    );

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Text.rich(
        TextSpan(
          children: _children
        )
      )
    );
  }

  Widget _buildPhotoWidget(BuildContext context) {
    if (model.pics.length == 1) {
      FSPondPiecePicModel _pic = model.pics.first;
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: _pic.width,
          height: _pic.height,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            image: DecorationImage(
              image: NetworkImage(_pic.url,),
              fit: BoxFit.cover
            )
          ),
        ),
      );
    } else if (model.pics.length == 4) {
      return Align(
        alignment: Alignment.centerLeft,
        child: Container(
          width: (Screen.width(context) - 40) / 3 * 2,
          child: GridView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.all(0),
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5
            ),
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return _buildGridPhotoItem(model.pics[index].url);
            },
          )
        ),
      );
    } else {
      return GridView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.all(0),
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5
        ),
        itemCount: model.pics.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildGridPhotoItem(model.pics[index].url);
        },
      );
    }
  }

  Widget _buildGridPhotoItem(String url) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        image: DecorationImage(
          image: NetworkImage(url,),
          fit: BoxFit.cover
        )
      ),
    );
  }

  Widget _buildStatisticWidget() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          ImageCoverPattern(
            images: [model.userAvatar, model.userAvatar, model.userAvatar],
            width: 30,
            height: 30,
            radius: 15,
            offset: 15,
            borderColor: Colors.white,
            borderWidth: 1,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              "${model.likeCount}人赞过",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14
              ),
            ),
          ),
          Text(
            "1个月前发布 浏览41434344",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14
            ),
          ),
        ],
      ),
    );
  }
}


class ImageCoverPattern extends StatelessWidget {
  ImageCoverPattern({
    Key key,
    this.images,
    this.width,
    this.height,
    this.radius, 
    this.offset = 10, 
    this.paddingH = 0,
    this.paddingV = 0,
    this.borderWidth = 1,
    this.borderColor = Colors.white
  }) : super(key: key);

  final List<String> images;
  final double width;
  final double height;
  final double radius; 
  final double offset;
  final double paddingH;
  final double paddingV;
  final double borderWidth;
  final Color borderColor;
  
  @override
  Widget build(BuildContext context) {
    List<Widget> avatarList = List();
    for(var i = 0; i < images.length; i++) {
      var start =  i * offset;
      var avatarItem = Positioned.directional(
        top: 0,
        bottom: 0,
        start: start,
        textDirection: TextDirection.rtl,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor, width: borderWidth),
            borderRadius: BorderRadius.circular(radius),
            image: DecorationImage(
              image: NetworkImage(images[i]),
              fit: BoxFit.cover
            )
          ),
        ),
      );
      avatarList.add(avatarItem);
    }

    return SizedBox(
      width: width + (width - offset) * (images.length - 1) + paddingH * 2,
      height: height + paddingV * 2,
      child: Stack(
        children: avatarList,
      ),
    );
  }

}