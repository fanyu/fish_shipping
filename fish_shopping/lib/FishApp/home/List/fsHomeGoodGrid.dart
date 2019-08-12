
import 'package:fish_shopping/FishApp/common/Network.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'fsHomeGoodItem.dart';
import 'fsHomeGoodModel.dart';

enum LoadingState {
  nona,
  loading,
  noMore,
}

class FHHomeGoodGrid extends StatefulWidget {  
  
  FHHomeGoodGrid({Key key, this.categoryType}) : super(key: key);

  final String categoryType;

  @override
  State<StatefulWidget> createState() {
    return _FHHomeGoodGridState();
  }
}

class _FHHomeGoodGridState extends State<FHHomeGoodGrid> with AutomaticKeepAliveClientMixin{
  
  int page = 0;
  LoadingState loadingState = LoadingState.nona; 
  bool isPerformingRequest = false;
  List<FHHomeGoodModel> datas = [];
  
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    fetchMoreData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return buildStaggeredGrid();
  }

  Widget buildStaggeredGrid() {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (BuildContext context) {
          return NotificationListener<ScrollEndNotification>(
            onNotification: (ScrollEndNotification scroll) {
              if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
                print("scroll to end");
                fetchMoreData();
              }
              return false;
            },
            child: Container(
              color: Colors.grey[100],
              child: CustomScrollView(
                key: PageStorageKey(widget.categoryType),
                slivers: <Widget>[
                  // 顶部偏移量
                  SliverOverlapInjector(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                  ),
                  
                  // 商品列表
                  SliverPadding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 10),
                    sliver: SliverStaggeredGrid.countBuilder(
                      crossAxisCount: 4,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      itemCount: datas.length,
                      itemBuilder: (BuildContext context, int index) {
                        return FHHomeGoodItem(model: datas[index],);
                      },
                      staggeredTileBuilder: (int index) {
                        return StaggeredTile.fit(2);
                      },
                    ),
                  ),

                  // 刷新控件
                  buildLoadingWidget(),
                ],
              ),
            )
          );
        },
      ),
    );
  }

  Widget buildGrid() {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 2
      ),
      delegate: SliverChildBuilderDelegate( 
        (BuildContext context, int index) {
          if (index < datas.length) {
            return FHHomeGoodItem(model: datas[index],);
          } else {
            return buildProgressIndicator();
          }
        },
        childCount: datas.length + 1,
      ),
    );
  }

  Widget buildProgressIndicator() {
    if (page < 3) {
      fetchMoreData();
      return Padding(
        padding: EdgeInsets.all(18),
        child: Center(
          child: Opacity(
            opacity: isPerformingRequest ? 1 : 0,
            child: CircularProgressIndicator(),
          ),
        ),
      );
    } else {
      return noMoreData();
    }
  }

  Widget buildLoadingWidget() {
    Widget tipWidget;

    if (loadingState == LoadingState.loading) {
      tipWidget = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(),
          ),
          SizedBox(width: 20,),
          Text("加载数据中...")
        ],
      );
    } 

    if (loadingState == LoadingState.noMore) {
      tipWidget = Text("暂时没有更多数据...");
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 30),
          child: tipWidget,
        ),
      )
    );
  }

  Widget noMoreData() {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 18, bottom: 30),
          child: Text(
            "no more data",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey
            ),
          ),
        ),
      ],
    );
  }

  Future<void> fetchMoreData() async {
    if (loadingState != LoadingState.loading) { 
      setState(() {
        loadingState = LoadingState.loading;
      });

      var responseJson = await EDCRequest.get(action: "fish_goods");
      List<FHHomeGoodModel> goods = [];
      responseJson.forEach( (data) {
        goods.add(FHHomeGoodModel.fromJSON(data));
      });
      
      Future.delayed(Duration(seconds: 2), () {
        if (!mounted){
          return;
        }

        setState(() {
          datas.addAll(goods);
          loadingState = LoadingState.nona;
          page++;
        });
      });
    }
  }
} 