
import 'package:fish_shopping/FishApp/Pond/list/widgets/FSPondAdsWidget.dart';
import 'package:fish_shopping/FishApp/Pond/list/widgets/FSPondPieceWidget.dart';
import 'package:fish_shopping/FishApp/Pond/list/widgets/FSPondTopicWidget.dart';
import 'package:fish_shopping/FishApp/Pond/piece_detail/FSPondPieceDetailPage.dart';
import 'package:fish_shopping/FishApp/common/Carousel.dart';
import 'package:fish_shopping/FishApp/common/Network.dart';
import 'package:fish_shopping/FishApp/common/RefreshDataWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'model/FSPondPieceModel.dart';

class FSPondList extends StatefulWidget {

  FSPondList({
    Key key,
    this.typeKey
  }) : super(key: key);

  final String typeKey;

  @override
  State<StatefulWidget> createState() {
    return _FSPondListState();
  }
}

class _FSPondListState extends State<FSPondList> with AutomaticKeepAliveClientMixin {

  List _dataList = [];
  int page = 0;
 
  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  void initState() {
    super.initState();
    refreshFirstData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildBody();
  }

  @override
  bool get wantKeepAlive => true;

  Widget buildBody() {
    if (_dataList.isEmpty) {
      return RefreshDataWidget();
    }   

    return EasyRefresh(
      key: _easyRefreshKey,
      behavior: ScrollOverBehavior(),
      refreshHeader: ClassicsHeader(
        key: _headerKey,
        refreshText: "pullToRefresh",
        refreshReadyText: "releaseToRefresh",
        refreshingText: "refreshing...",
        refreshedText: "refreshed",
        moreInfo: "updateAt",
        bgColor: Colors.yellow,
        textColor: Colors.black87,
        moreInfoColor: Colors.black54,
        showMore: true,
      ),
      refreshFooter: ClassicsFooter(
        key: _footerKey,
        loadText: "pushToLoad",
        loadReadyText: "releaseToLoad",
        loadingText: "loading",
        loadedText: "loaded",
        noMoreText: "noMore",
        moreInfo: "updateAt",
        bgColor: Colors.transparent,
        textColor: Colors.black87,
        moreInfoColor: Colors.black54,
        showMore: true,
      ),
      autoLoad: true,
      child: buildList(),
      onRefresh: refreshFirstData,
      loadMore: refreshMoreData,
    );
  }

  Widget buildList() {
    return ListView.builder(
      itemCount: 2 + _dataList.length,
      itemBuilder: (BuildContext context, int index) {
        // topic 
        if (index == 0) {
          return FSPondTopicWidget();
        } else if (index == 1) {
          return FSPondAdsWidget(widget.typeKey, () {
            
          });
        } else {
          int rebaseIndex = index - 2;
          var model = _dataList[rebaseIndex];
          if (model is FSPondPieceModel) {
            return FSPondPieceWidget(model: model, callback: (){
               Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return FSPondPieceDetailPage(model);
                })
              );
            });

          } else if (model is List) {
            return Carousel(
              images: mockCarouselData(),
              margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              aspectRatio: 3,
              interval: 4,
              indicatorBottom: 20,
            );

          } else {
            return Container(
              child: Text("Not Support This Message"),
            );
          }
        }    
      },
    );
  }

  List<String> mockCarouselData() {
    return [
      'images/image_01.png',
      'images/image_02.jpg',
      'images/image_03.jpg',
      'images/image_04.jpg',
    ];
  }

  Future refreshFirstData() async {    
    var responseJson = await EDCRequest.get(action: "fish_pieces");
    
    List<FSPondPieceModel> pieces = [];
    responseJson.forEach( (data) {
      pieces.add(FSPondPieceModel.fromJSON(data));
    });
    
    Future.delayed(Duration(seconds: 1), () {
      if (!mounted){
        return;
      }
      setState(() {
        _dataList.clear();
        _dataList.addAll(pieces);
        _dataList.insert(1, mockCarouselData());
        page = 0;
      });
    });
  }

  Future refreshMoreData() async {
    var responseJson = await EDCRequest.get(action: "fish_pieces");
    
    List<FSPondPieceModel> pieces = [];
    responseJson.forEach( (data) {
      pieces.add(FSPondPieceModel.fromJSON(data));
    });
    
    Future.delayed(Duration(seconds: 2), () {
      if (!mounted){
        return;
      }
      setState(() {
        _dataList.addAll(pieces);
        page++;
      });
    });

  }

}