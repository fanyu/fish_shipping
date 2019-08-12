
import 'package:fish_shopping/FishApp/Pond/comment/FSPondCommentModel.dart';
import 'package:fish_shopping/FishApp/Pond/comment/FSPondCommentWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class FSPondPieceHotCommentList extends StatefulWidget {

  FSPondPieceHotCommentList(this.list);

  final List<FSPondCommentModel> list;

  @override
  State<StatefulWidget> createState() {
    return _FSPondPieceHotCommentListState();
  }
}

class _FSPondPieceHotCommentListState extends State<FSPondPieceHotCommentList> {

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if (index == 0) {
              return _buildHeader();
            } else {
              return FSPondCommentWidget(widget.list[index - 1], true);
            }
          },
          childCount: widget.list.length + 1,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Text(
        "热门评论・${widget.list.length}",
        style: TextStyle(
          color: Colors.black,
          fontSize: 20,
        ),
      ),
    );
  }
}