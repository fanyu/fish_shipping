

import 'package:fish_shopping/FishApp/Pond/comment/FSPondCommentModel.dart';
import 'package:fish_shopping/FishApp/Pond/list/model/FSPondPieceModel.dart';
import 'package:fish_shopping/FishApp/Pond/piece_detail/widget/FSPondPieceHotCommentList.dart';
import 'package:fish_shopping/FishApp/common/Network.dart';
import 'package:fish_shopping/FishApp/common/RefreshDataWidget.dart';
import 'package:flutter/material.dart';
import 'widget/FSPondPieceAllCommentList.dart';
import 'widget/FSPondPieceEntry.dart';
import 'widget/FSPondPieceInfoWidget.dart';
import 'widget/FSPondPieceRecommand.dart';

class FSPondPieceDetailPage extends StatefulWidget {
  
  FSPondPieceDetailPage(this.model);

  final FSPondPieceModel model;

  @override
  State<StatefulWidget> createState() {
    return _FSPondPieceDetailPageState();
  }
}

class _FSPondPieceDetailPageState extends State<FSPondPieceDetailPage> {

  List<FSPondCommentModel> _hotCommentList = [];
  List<FSPondCommentModel> _allCommentList = [];

  @override
  void initState() {
    super.initState();
    
    fetchHotComment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            onPressed: () { },
            icon: Icon(Icons.more_horiz),
            color: Colors.black,
          )
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_hotCommentList.isEmpty) {
      return RefreshDataWidget();
    }

    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          FSPondPieceInfoWidget(widget.model),
          _separtor(),
          FSPondPieceEntry(),
          _separtor(),
          FSPondPieceHotCommentList(_hotCommentList),
          _separtor(),
          FSPondPieceAllCommentList(_allCommentList, fetchAllComment),
          _buildRecommandHeader(),
          FSPondPieceRecommand(_recommandData()),
        ],
      ),
    );
  }

  List<FSPondPieceModel> _recommandData() {
    List<FSPondPieceModel> _list = [];
    for (var i = 0; i < 20; i++) {
      FSPondPieceModel model = widget.model;
      _list.add(model);
    }
    return _list;
  }

  Widget _buildRecommandHeader() {
    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        color: Colors.grey[200],
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Text(
          "一 相关推荐 一",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
          ),
        ),
        )
      ),
    );
  }

  Widget _separtor() {
    return SliverToBoxAdapter(
      child: Container(
        height: 10,
        color: Colors.grey[200],
      ),
    );
  }

 Future fetchHotComment() async {
    var responseJson = await EDCRequest.get(action: "fish_commentHot");
    
    List<FSPondCommentModel> comments = [];
    responseJson.forEach( (data) {
      comments.add(FSPondCommentModel.fromJSON(data));
    });
    
    Future.delayed(Duration(seconds: 2), () {
      if (!mounted){
        return;
      }
      setState(() {
        _hotCommentList.addAll(comments);
        _allCommentList.addAll(comments);
      });
    });
  }

   Future fetchAllComment() async {
    var responseJson = await EDCRequest.get(action: "fish_commentHot");
    
    List<FSPondCommentModel> comments = [];
    responseJson.forEach( (data) {
      comments.add(FSPondCommentModel.fromJSON(data));
    });
    
    Future.delayed(Duration(milliseconds: 500), () {
      if (!mounted){
        return;
      }
      setState(() {
        _allCommentList.addAll(comments);
      });
    });
  }

}