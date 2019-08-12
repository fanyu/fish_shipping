

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RefreshDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          color: Colors.grey[50],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircularProgressIndicator(
                backgroundColor: Colors.yellow,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "加载中...",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}