
import 'package:flutter/material.dart';

import 'FSMineItem.dart';

class FSMineBuy extends StatelessWidget {
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
                  "买在闲鱼",
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
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              shrinkWrap: true,
              childAspectRatio: 1.9,
              padding: EdgeInsets.all(0),
              children: <Widget>[
                FSMineItem(image: "https://cataas.com/cat", title: "我买到的 21"),
                FSMineItem(image: "https://cataas.com/cat", title: "我收藏的 0"),
                FSMineItem(image: "https://cataas.com/cat", title: "参与的免费送"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}