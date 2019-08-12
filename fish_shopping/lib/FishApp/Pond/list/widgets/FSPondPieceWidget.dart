
import 'package:fish_shopping/FishApp/Pond/list/model/FSPondPieceModel.dart';
import 'package:fish_shopping/utils/Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


typedef void TapPieceCallback();

class FSPondPieceWidget extends StatefulWidget {

  FSPondPieceWidget({
    Key key,
    this.model,
    this.callback
  }) : super(key: key);

  final FSPondPieceModel model;
  final TapPieceCallback callback;

  @override
  State<StatefulWidget> createState() {
    return _FSPondPieceWidgetState();
  }
}

class _FSPondPieceWidgetState extends State<FSPondPieceWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _children = [];
    
    if (widget.model.pondName != "") {
      _children.add(_buildPondSourceWidget());
    }
    
    _children.add(_buildUserProfileWidget());
    
    if (widget.model.topic != "") {
      _children.add(_buildTopicWidget());  
    }

    _children.add(_buildContextWidget());

    if (widget.model.pics.length != 0) {
      _children.add(_buildPhotoWidget());
    }

    if (widget.model.hotComment != "") {
      _children.add(_buildHotCommentWidget());
    }

    _children.add(_buildToolBarWidget());

    return GestureDetector(
      onTap: () {
        widget.callback();
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _children,
            ),
          )
        )
      ),
    );
  }

  Widget _buildPondSourceWidget() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Colors.grey[100],
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.all_out,
            color: Colors.blue,
            size: 24,
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "来自${widget.model.pondName}鱼塘",
            style: TextStyle(
              color: Colors.blue,
              fontSize: 16
            ),
          ),
        ],
      )
    );
  }

  Widget _buildUserProfileWidget() {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(widget.model.userAvatar),
            radius: 15,
          ),

          SizedBox(
            width: 10,
          ),

          Text(
            widget.model.userName,
            style: TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTopicWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Text(
        widget.model.topic,
        maxLines: null,
        softWrap: true,
        style: TextStyle(
          color: Colors.blue,
          fontSize: 17,
          fontWeight: FontWeight.w300
        ),
      ),
    );
  }

  Widget _buildContextWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Text(
        widget.model.content,
        maxLines: null,
        softWrap: true,
        style: TextStyle(
          color: Colors.black87,
          fontSize: 17,
          fontWeight: FontWeight.w400
        ),
      ),
    );
  }


  Widget _buildPhotoWidget() {
    if (widget.model.pics.length == 1) {
      FSPondPiecePicModel _pic = widget.model.pics.first;
      return Container(
        margin: EdgeInsets.all(10),
        width: _pic.width,
        height: _pic.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          image: DecorationImage(
            image: NetworkImage(_pic.url,),
            fit: BoxFit.cover
          )
        ),
      );
    } else if (widget.model.pics.length == 4) {
      return Container(
        padding: EdgeInsets.all(10),
        width: (Screen.width(context) - 40) / 3 * 2,
        child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5
          ),
          itemCount: 4,
          itemBuilder: (BuildContext context, int index) {
            return _buildGridPhotoItem(widget.model.pics[index].url);
          },
        ),
      );
    } else {
      return GridView.builder(
        padding: EdgeInsets.all(10),
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5
        ),
        itemCount: widget.model.pics.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildGridPhotoItem(widget.model.pics[index].url);
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

  Widget _buildHotCommentWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(4)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.symmetric(vertical: 1, horizontal: 6),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.yellow
                  ),
                  child: Text(
                    "热评",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize:12
                    )
                  ),
                ),
        
                Text(
                  "${widget.model.hotLikeCount}赞",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize:12,
                    fontWeight: FontWeight.w400
                  )
                )
              ],
            ),

            SizedBox(
              height: 4,
            ),

            Text(
              widget.model.hotComment,
              maxLines: null,
              style: TextStyle(
                color: Colors.black,
                fontSize:15,
                fontWeight: FontWeight.w300
              )
            ),
          ],
        ),
      )
    );
  }

  Widget _buildToolBarWidget() {
    return Container(
      padding: EdgeInsets.all(14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _buildToolbarItem(Icons.share, "分享", false),
          _buildToolbarItem(Icons.chat_bubble_outline, widget.model.commentCount, false),
          _buildToolbarItem(Icons.favorite, widget.model.likeCount, widget.model.liked),
        ],
      ),
    );
  }

  Widget _buildToolbarItem(IconData icon, String title, bool liked) {
    return GestureDetector(
      onTap: () {
        setState(() {
          //widget.model.liked = false;
        });
      },
      child: Row(
        children: <Widget>[
          Icon(
            liked ? Icons.favorite : icon,
            size: 24,
            color: liked ? Colors.red : Colors.grey,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 14,
              fontWeight: FontWeight.w300
            )
          )
        ],
      ),
    );
  }
}