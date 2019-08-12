

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FSMineItem extends StatelessWidget {
  
  FSMineItem({
    Key key,
    this.image,
    this.title
  }) : super(key: key);

  final String image;
  final String title;
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Image(
          image: CachedNetworkImageProvider(image),
          width: 35,
          height: 35,
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          title,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14
          )
        )
      ],
    );
  }
}