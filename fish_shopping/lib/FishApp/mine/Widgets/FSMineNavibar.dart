
import 'package:fish_shopping/utils/Screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FSMineNavibar extends StatelessWidget {
  
  FSMineNavibar(this.opacity);

  final double opacity;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: opacity,
          child: Container(
            padding: EdgeInsets.fromLTRB(5, Screen.statusBarHeight(context), 0, 0),
            height: Screen.navigationBarHeight(context),
            color: opacity == 0 ? Colors.transparent : Colors.yellow,
            child: Center(
              child: Text(
                "专卖小铺子",
                style: TextStyle(
                  color: opacity == 0 ? Colors.transparent : Colors.black,
                  fontSize: 17
                ),
              ),
            ),
          ),
        ),

        Positioned(
          right: 0,
          child: Opacity(
            opacity: opacity,
            child: Container(
              margin: EdgeInsets.fromLTRB(5, Screen.statusBarHeight(context), 0, 0),
              child: IconButton(
                onPressed: () {

                },
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.settings),
                iconSize: 30,
                color: Colors.black,
              ),
            )
          )
        ),
      ],
    );
  }
}