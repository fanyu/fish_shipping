

import 'package:flutter/material.dart';

import 'FSMineItem.dart';

class FSMineTool extends StatelessWidget {

  final List<String> _list = [
    "安全中心","客服中心","我的红包","我租到的","我的租房","我的拍卖","闲鱼公约","实人通行证","闲鱼招商","闲鱼family"
  ];

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
                  "其他工具",
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

            GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.4,
              ),
              shrinkWrap: true,
              padding: EdgeInsets.all(0),
              itemCount: _list.length,
              itemBuilder: (BuildContext context, int index) {
                return FSMineItem(image: "https://cataas.com/cat", title: _list[index]);
              },
            )
          ],
        ),
      ),
    );
  }
}