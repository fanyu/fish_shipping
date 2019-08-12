
import 'package:fish_shopping/FishApp/Message/FSMessageListItem.dart';
import 'package:fish_shopping/FishApp/Message/FSMessageModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

import 'FSMessageHeader.dart';

class FSMessagePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FSMessagePageState();
  }
}

class _FSMessagePageState extends State<FSMessagePage> with AutomaticKeepAliveClientMixin {
  
  List<FSMessageModel> _messageList = [
    FSMessageModel(avatar: "https://cataas.com/cat", name: "我关注的", content: "imsdh666发布了全新金色Xs Max 64 无敌iPhone", date: "1天前", image: "https://cataas.com/cat"),
    FSMessageModel(avatar: "https://cataas.com/cat", name: "qiqi1015122", content: "no", date: "1个月前", image: "https://cataas.com/cat"),
    FSMessageModel(avatar: "https://cataas.com/cat", name: "122222", content: "no", date: "1个月前", image: "https://cataas.com/cat"),
    FSMessageModel(avatar: "https://cataas.com/cat", name: "edceezz", content: "你有一条消息", date: "1个月前", image: "https://cataas.com/cat"),
  ];

  GlobalKey<EasyRefreshState> _easyRefreshKey = GlobalKey<EasyRefreshState>();
  GlobalKey<RefreshHeaderState> _headerKey = GlobalKey<RefreshHeaderState>();
  GlobalKey<RefreshFooterState> _footerKey = GlobalKey<RefreshFooterState>();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print("Init Message page");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);    
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.yellow,
        title: Text(
          "消息",
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: buildBody(),    
    );
  }

  // Widget body() {
  //   return Refresh(
  //     onHeaderRefresh: () {},
  //     child: buildList(),
  //   );
  // }

  Widget buildBody() {
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
        showMore: false,
      ),
      autoLoad: false,
      child: buildList(),
      onRefresh: refreshFirstData,
      loadMore: refreshMoreData,
    );
  }

  Widget buildList() {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: Container(
            child: FSMessageHeader(),
          ),
        ),

        SliverToBoxAdapter(
          child: SizedBox(
            height: 10,
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext buildContext, int index) {
              //return FSMessageListItem(message: _messageList[index], isMyFollow: index == 0,);
              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: FSMessageListItem(message: _messageList[index], isMyFollow: index == 0,),
                onTap: () {
                  print(index);  
                },
              );
            },
            childCount:_messageList.length,
          ),
        )
      ],
    );
  }

  Future refreshFirstData() async {    
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        
      });
    });
  }

  Future refreshMoreData() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        
      });
    });
  }
}