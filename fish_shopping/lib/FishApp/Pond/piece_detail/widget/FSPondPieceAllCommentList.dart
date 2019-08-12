

import 'package:fish_shopping/FishApp/Pond/comment/FSPondCommentModel.dart';
import 'package:fish_shopping/FishApp/Pond/comment/FSPondCommentWidget.dart';
import 'package:flutter/material.dart';

class FSPondPieceAllCommentList extends StatefulWidget {

  FSPondPieceAllCommentList(this.list, this.fetchMore);

  final List<FSPondCommentModel> list;
  final VoidCallback fetchMore;

  @override
  State<StatefulWidget> createState() {
    return _FSPondPieceAllCommentListState();
  }
}

class _FSPondPieceAllCommentListState extends State<FSPondPieceAllCommentList> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      sliver: SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            if (index == 0) {
              return _buildHeader();
            } else if (index == widget.list.length + 1) {
              return _buildFooter();
            } else {
              return FSPondCommentWidget(widget.list[index - 1], false);
            }
          },
          childCount: widget.list.length + 2,
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

  Widget _buildFooter() {
    return GestureDetector(
      onTap: () {
        widget.fetchMore();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "加载更多评论",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
              ),
            ),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.blue,
              size: 16,
            )
          ],
        )
      ),
    );
  }
}