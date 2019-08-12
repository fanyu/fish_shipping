
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fish_shopping/FishApp/Category/FSCategoryPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FSHomeHeaderCategory extends StatelessWidget {

  final List<String> _categoryList = ["二手手机", "数码",    "二手图书", "母婴玩具", "家具家电",
                                      "服饰鞋包", "美妆闲置", "二手车",  "超值租",   "全部分类"];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(14)),
      ),
      child: GridView(
        shrinkWrap: true, // 收缩，只占用他需要的大小，而不是占满全屏
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1
        ),
        children: _categoryList.map((String name){
          return GestureDetector(
            onTap: () {
              if (name == "全部分类") {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return FSCategoryPage();
                  })
                );
              }
            },
            child:  Container(
              child: Column(
                children: <Widget>[
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.cyan[100],
                    backgroundImage: CachedNetworkImageProvider("https://cataas.com/cat"),
                  ),
                  Text(
                    name,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w300
                    ),
                  ),
                ],
              ),
            )
          );
        }).toList(),
      ),
    );
  }
}