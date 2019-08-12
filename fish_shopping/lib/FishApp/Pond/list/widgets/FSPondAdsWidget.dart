
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef void FSPondAdsTapCallback();

class FSPondAdsWidget extends StatelessWidget {
  
  FSPondAdsWidget(this.type, FSPondAdsTapCallback callback);

  final String type;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage("images/image_03.jpg"),
                fit: BoxFit.cover
              )
            ),
          ),

          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: "这是 ",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: type,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
                TextSpan(
                  text: " 的广告位",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ]
            )
          ),
        ],
      )
    );
  }
}