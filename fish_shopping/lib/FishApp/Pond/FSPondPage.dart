

import 'package:fish_shopping/FishApp/Pond/FixedTabIndicator.dart';
import 'package:fish_shopping/utils/Screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'list/FSPondList.dart';

class FSPondPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FSPondPageState();
  }
}

class _FSPondPageState extends State<FSPondPage> with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  
  TabController _tabController;
  List<String> _list = ["我加入的","推荐","数码","运动","穿搭","美食旅行","母婴","美妆","文化艺术","复古","DIY","宠物",
    "汽车","文玩","更多",
  ];
 
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: _list.length,  initialIndex: 1, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: _buildAppbar(),
      body: _buildTabBarView(),
    );
  }

  Widget _buildAppbar() {
    return AppBar(
      backgroundColor: Colors.yellow,
      elevation: 0,
      title: Text(
        "鱼塘",
        style: TextStyle(
          fontSize: 17,
          color: Colors.black
        ),
      ),
      leading: IconButton(
        onPressed: () {

        },
        icon: Icon(Icons.search)
      ),
      actions: <Widget>[
        _buildPostButton(),
      ],
      bottom: PreferredSize(
        preferredSize: Size(Screen.width(context), 36),
        child: _buildTabBar(),
      ),
    );
  }
  Widget _buildPostButton() {
    return GestureDetector(
      onTap: () {

      },
      child: Container(
        height: 20,
        margin: EdgeInsets.fromLTRB(0, 12, 12, 10),
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white
        ),
        child: Row(
          children: <Widget>[
            Icon(
              Icons.edit,
              color: Colors.black,
              size: 16
            ),
            Text(
              "发帖子",
              style: TextStyle(
                color: Colors.black,
                fontSize: 14,
                fontWeight: FontWeight.bold
              )
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      isScrollable: true,
      indicator: FixedUnderlineTabIndicator(
        width: 16,
        borderSide: BorderSide(
          color: Colors.black,
          width: 3,
        ),
      ),
      indicatorWeight: 8,
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black54,
      labelStyle: TextStyle(
        fontSize: 15
      ),
      labelPadding: EdgeInsets.symmetric(horizontal: 13),
      tabs: _list.map((String title){
        return Text(
          title,
        );
      }).toList(),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: _list.map((String title){
        return Container(
          color: Colors.grey[300],
          child: FSPondList(typeKey: title,),
        );
      }).toList(),
    );
  }

}