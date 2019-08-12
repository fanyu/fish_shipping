
import 'package:fish_shopping/FishApp/Mine/Widgets/FSMineBuy.dart';
import 'package:fish_shopping/FishApp/Mine/Widgets/FSMinePlay.dart';
import 'package:fish_shopping/FishApp/Mine/Widgets/FSMineTool.dart';
import 'package:fish_shopping/utils/Screen.dart';
import 'package:flutter/material.dart';

import 'Widgets/FSMineHeader.dart';
import 'Widgets/FSMineNavibar.dart';
import 'Widgets/FSMineSell.dart';

class FSMinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FSMinePageState();
  }
}

class _FSMinePageState extends State<FSMinePage> with AutomaticKeepAliveClientMixin {

  double naviAlpha = 0;
  ScrollController _scrollController;

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    super.initState();
    print("Init Mine page");

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      var offset = _scrollController.offset;
      if (offset < 0) {
        setState(() {
          naviAlpha = 0;
        });
      } else if (offset < 50) {
        setState(() {
          naviAlpha = 1 - (50 - offset) / 50;
        });
      } else if (naviAlpha != 1) {
        setState(() {
          naviAlpha = 1;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 80),
            height: Screen.height(context),
            color: Colors.grey[100],
          ),
          ListView(
            controller: _scrollController,
            children: <Widget>[
              FSMineHeader(),
              SizedBox(height: 10,),
              FSMineSell(),
              SizedBox(height: 10,),
              FSMineBuy(),
              SizedBox(height: 10,),
              FSMinePlay(),
              SizedBox(height: 10,),
              FSMineTool(),
              SizedBox(height: 40,),
            ],
          ),

          FSMineNavibar(naviAlpha),
        ],
      )
    );
  }
}
