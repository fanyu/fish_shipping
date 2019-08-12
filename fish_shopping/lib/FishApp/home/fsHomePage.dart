
import 'package:fish_shopping/FishApp/Search/FSSearchPage.dart';
import 'package:flutter/material.dart';

import 'Header/fsHomeHedaer.dart';
import 'List/fsHomeGoodGrid.dart';

class FSHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FSHomePageState();
  }
}

class _FSHomePageState extends State<FSHomePage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  
  List<String> _list = ["关注","新鲜","手机","电脑","数码","租房","服装","家具",];

  TabController _tabController;
  
  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    super.initState();
    print("Init Home page");

    _tabController = TabController(length: _list.length, vsync: this);
    _tabController.addListener( () {
      var index = _tabController.index;
      var previewIndex = _tabController.previousIndex;
      print('index:$index, preview:$previewIndex');
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: buildAppBarWidget(),
      body: buildBodyWidget(),
    );
  }

  Widget buildAppBarWidget() {
    return  AppBar(
      titleSpacing: 0,
      title: buildSearchBar(),
      centerTitle: false,
      elevation: 0,
      backgroundColor: Colors.yellow,  
      actions: <Widget>[
        IconButton(
          splashColor: Colors.transparent,
          padding: EdgeInsets.all(0),
          icon: Icon(Icons.crop_free),
          onPressed: () {
            print("3333");
          },
        ),
      ],
    );
  }

  Widget buildBodyWidget() {
    return Scrollbar(
      child: buildNestedScrollView(),
    );
  }

  Widget buildNestedScrollView() {
    return NestedScrollView(
      headerSliverBuilder: ( (BuildContext context, bool innerIsScrolled) {
        return <Widget>[
          // header 
          SliverToBoxAdapter(
            child: FSHomeHedaer(),
          ),

          // bar 
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            child: SliverAppBar(
              pinned: true,
              titleSpacing: 0,
              forceElevated: false,
              automaticallyImplyLeading: false,
              backgroundColor: innerIsScrolled ? Colors.white : Colors.grey[100],
              title: TabBar(
                controller: _tabController,
                indicatorColor: Colors.yellow,
                indicatorWeight: 3,
                indicatorPadding: EdgeInsets.fromLTRB(0, 0, 0, 6),
                unselectedLabelStyle: TextStyle(color: Colors.black45, fontSize: 16),
                labelStyle: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                indicatorSize: TabBarIndicatorSize.label,
                isScrollable: true,
                tabs: _list.map( (String name) {
                  return Tab(
                    text: name,
                  );
                }).toList()
              ),
            ),
          ),
        ];
      }),

      body: TabBarView(
        controller: _tabController,
        children: _list.map( (String name) {
          return FHHomeGoodGrid(categoryType: name,);
        }).toList(),
      ),
    );
  }

  Widget buildListWidget(String name) {
    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(builder: (BuildContext context) {
        return CustomScrollView(
          key: PageStorageKey(name),
          slivers: <Widget>[
            SliverOverlapInjector(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(bottom: 0),
              sliver: SliverFixedExtentList(
                itemExtent: 50,
                delegate: SliverChildBuilderDelegate( 
                  (BuildContext context, int index) {
                    return Text("index = $index");
                  },
                  childCount: 30
                ),
              ),
              
            ),
          ],
        );
      }),
    );
  }
  
  Widget buildSearchBar() {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 10,
        ),

        Text(
          "闲鱼",
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
     
        SizedBox(width: 10),
        
        Expanded(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder( // 无动画的切换
                  pageBuilder: (context, anim1, anim2) => FSSearchPage(),
                ),
              );
            },
            child: Container(
              height: 30,
              padding: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.search,
                    size: 18,
                    color: Colors.grey[400],
                  ),

                  SizedBox(width: 5),
                  
                  Text(
                    "iPhoneXr手机壳",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.w300
                    )
                  )
                ],
              ),
            ),
          )
        ) 
      ],
    );
  }
  
  Future<void> fetchData() async {
    return null;
  }
}