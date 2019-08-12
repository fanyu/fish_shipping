
import 'package:fish_shopping/FishApp/Pond/list/model/FSPondPieceModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FSPondPieceRecommand extends StatelessWidget {

  FSPondPieceRecommand(this.list);

  final List<FSPondPieceModel> list;

  @override
  Widget build(BuildContext context) {
    return _buildGrid();
  }

  Widget _buildGrid() {
   return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: 0.7,
      ),
      delegate: SliverChildBuilderDelegate( 
        (BuildContext context, int index) {
          return _buildRecommandItem(list[index], index % 2 == 0);
        },
        childCount: list.length,
      ),
    );
  }

  Widget _buildRecommandItem(FSPondPieceModel model, bool isLeft) {
    // 由于父视图背景是白色，所以自己添加边距来实现底色灰色
    double left = isLeft ? 10 : 5;
    double right = isLeft ? 5 : 10;
    return Container(
      padding: EdgeInsets.fromLTRB(left, 0, right, 10),
      color: Colors.grey[200],
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: Colors.white,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AspectRatio(
              aspectRatio: 1,
              child: Image(
                image: NetworkImage(model.userAvatar),
                fit: BoxFit.cover,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                model.content,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 16,
                )
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                children: <Widget>[
                  CircleAvatar(
                    backgroundImage: NetworkImage(model.userAvatar),
                    radius: 15,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  Expanded(
                    child: Text(
                      model.userName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w300
                      )
                    ),
                  ),
                  Text(
                    "${model.likeCount}人赞了",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12
                    )
                  ),
                ],
              ),
            )
          ],
        ),
        ),
      ),
    );
  }
}