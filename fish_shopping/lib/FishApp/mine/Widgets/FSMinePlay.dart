
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'FSMineItem.dart';

class FSMinePlay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "玩在闲鱼",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16
                  )
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  "在闲鱼赚了1867.00元",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14
                  )
                ),
              ],
            ),
            
            SizedBox(
              height: 16,
            ),

            // grid 
            GridView.count(
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              childAspectRatio: 1.2,
              padding: EdgeInsets.all(0),
              children: <Widget>[
                FSMineItem(image: "https://cataas.com/cat", title: "我的鱼塘"),
                FSMineItem(image: "https://cataas.com/cat", title: "我的帖子"),
                FSMineItem(image: "https://cataas.com/cat", title: "3小时公益"),
                FSMineItem(image: "https://cataas.com/cat", title: "百币多宝"),
                FSMineItem(image: "https://cataas.com/cat", title: "闲鱼币"),
                FSMineItem(image: "https://cataas.com/cat", title: "助卖宝卡"),
              ],
            ),

            // tip 
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(10)
              ),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 20,
                    height: 20,
                    child: Icon(
                      Icons.check_box,
                    ),
                  ),

                  SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: Text(
                      "已签到0天，连签7天得550闲鱼币",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14
                      )
                    ),
                  ),

                  Container(
                    height: 30,
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      color: Colors.white24,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.blue[400], width: 0.5)
                    ),
                    child: Center(
                      child: Text(
                        "去签到",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.w400
                        )
                      ),
                    ),
                  )

                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}