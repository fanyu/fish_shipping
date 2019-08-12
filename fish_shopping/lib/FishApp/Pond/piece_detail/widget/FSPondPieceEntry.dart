
import 'package:fish_shopping/FishApp/Pond/pond_detail/model/FSPondDetailModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FSPondPieceEntry extends StatelessWidget {
  
  FSPondPieceEntry({this.model});

  FSPondDetailModel model;

  @override
  Widget build(BuildContext context) {
    
    if (model == null) {
      model = FSPondDetailModel.fromJSON(
        {
          "id":"11", 
          "avatar":"https://cataas.com/cat", 
          "name":"美丽代太原",
          "hotCount": "8070354",
          "topicCount": "11761"
        }
      );
    }

    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: NetworkImage(model.avatar),
                  fit: BoxFit.cover
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "来自 ⌜${model.name}⌟ 鱼塘",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18
                    ),
                  ),
                  SizedBox(
                    height: 3,
                  ),
                  Text(
                    "人气${model.hotCount}・${model.topicCount}条帖子",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14
                    ),
                  )
                ],
              ),
            ),
            Container(
              //height: 40,
              padding: EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "进鱼塘",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}