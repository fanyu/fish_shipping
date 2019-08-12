
import 'package:fish_shopping/FishApp/Pond/comment/FSPondCommentModel.dart';
import 'package:fish_shopping/rich_text/rt_image_span.dart';
import 'package:fish_shopping/rich_text/rt_rich_text.dart';
import 'package:fish_shopping/utils/Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class FSPondCommentWidget extends StatefulWidget {

  FSPondCommentWidget(this.model, this.isHot);

  final FSPondCommentModel model;
  final bool isHot;

  @override
  State<StatefulWidget> createState() {
    return _FSPondCommentWidgetState();
  }
}

class _FSPondCommentWidgetState extends State<FSPondCommentWidget> {
  @override
  Widget build(BuildContext context) {
    List<Widget> list = [
      Divider(),
      _buildUserInfo(),
      _buildComment(),
      _buildDate()
    ];

    if (widget.model.replys != null) {
      list.add(_buildReply());
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: list,
    );
  }

  Widget _buildUserInfo() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(widget.model.userAvatar),
            radius: 15,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              widget.model.userName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 16
              )
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                widget.model.liked = !widget.model.liked;
              });
            },
            child: Row(
              children: <Widget>[
                Icon(
                  widget.model.liked ? Icons.favorite : Icons.favorite_border,
                  color: widget.model.liked ? Colors.yellow : Colors.black87,
                  size: 20,
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  widget.model.likeCount,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 12
                  )
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildComment() {
    List<TextSpan> list = [];

    if (widget.isHot) {
      list.add(
        RTImageSpan(
          AssetImage("images/hotcomment.png"),
          imageWidth: 60,
          imageHeight: 24,
          margin: EdgeInsets.zero
        ),
      );
    } 
    
    list.add(
      TextSpan(
        text: widget.model.comment,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.w300
        ),
      ),
    );

    return Padding(
      padding: EdgeInsets.fromLTRB(40, 10, 10, 10),
      child: RTRichText(
        list
      )
    );
  }

  Widget _buildDate() {
    return Container(
      padding: EdgeInsets.only(left: 40),
      child: Text(
        widget.model.date,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 14,
          fontWeight: FontWeight.w300
        ),
      ),
    );
  }

  Widget _buildReply() {
    List<Widget> replyList = [];
    
    List replys;

    if (widget.model.replys.length >= 2) {
      replys = widget.model.replys.sublist(0, 2);
    } else {
      replys = widget.model.replys;
    }

    for (var i = 0; i < replys.length; i++) {
      FSPondCommentReplyModel reply = replys[i];
      replyList.add(
        Text(
          "${reply.userName}：${reply.comment}",
          maxLines: null,
          softWrap: true,
          textWidthBasis: TextWidthBasis.longestLine,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.w400
          ),
        )
      );

      if (i != replys.length - 1) {
        replyList.add(
          SizedBox(
            height: 10,
          )
        );
      }
    }

    if (widget.model.replys.length > 2) {
      replyList.add(
        SizedBox(
          height: 10,
        )
      );
      replyList.add(
        Row(
          children: <Widget>[
            Text(
              "查看${widget.model.replys.length - 2}条回复",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 16,
                fontWeight: FontWeight.w400
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.blue,
              size: 14,
            )
          ],
        )
      );
    }

    return Padding(
      padding: EdgeInsets.fromLTRB(40, 10, 10, 10),
      child: Container(
        width: Screen.width(context) - 40 - 10,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8)
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: replyList,
        )
      ),
    );
  }

}