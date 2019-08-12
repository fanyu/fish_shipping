
import 'package:fish_shopping/utils/PlatformTheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Home/FSHomePage.dart';
import 'Message/FSMessagePage.dart';
import 'Mine/FSMinePage.dart';
import 'Pond/FSPondPage.dart';
import 'Post/FSPostPage.dart';

class FishApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Fish",
      theme: defaultTargetPlatform == TargetPlatform.iOS 
        ? PlatformTheme.iOS
        : PlatformTheme.android, // 根据平台选则
      home: FishHome(),
    );
  }
}

class FishHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FishHomeState();
  }
}

class _FishHomeState extends State<FishHome> {

  int _tabIndex = 0;
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _tabIndex, keepPage: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: _pages,
        physics: NeverScrollableScrollPhysics(), // 禁止滑动
      ),
      floatingActionButton: circleButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: Colors.white,
        inactiveColor: normalColor,
        activeColor: normalColor,
        items: _bottomNaviItems(),
        currentIndex: _tabIndex,
        onTap: didSelectedIndex,
      ),
    );
  }

  didSelectedIndex(int index) {
    setState(() {
      _tabIndex = index;
      _pageController.jumpToPage(index);
    });
  }

  void didTapPost() {
    // 无动画的切换
    Navigator.push(
      context,
      PageRouteBuilder( 
        pageBuilder: (context, anim1, anim2) => FSPostPage(),
      )
    );
  }

  Widget circleButton() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: EdgeInsets.all(6),
          child: FlatButton(
            padding: EdgeInsets.only(right: 0),   // 修正child偏移量，剧中
            //highlightColor: Colors.transparent, // 取消高亮
            splashColor: Colors.transparent,      // 取消水波
            shape: CircleBorder(),
            color: Colors.yellow,
            child: Icon(
              Icons.add,
              color: Colors.black,
              size: 40,
            ), 
            onPressed: () {
              //didSelectedIndex(2);
              didTapPost();
            },
          ),
        ),
      ),
    );
  }

  // Pages  
  List<StatefulWidget> _pages = [
    FSHomePage(),     // 首页
    FSPondPage(),     // 鱼塘
    FSPostPage(),     // 发布
    FSMessagePage(),  // 消息
    FSMinePage(),     // 我的
    //FSHomeX(),
  ];

  static final Color normalColor = Colors.black;
  static final Color selectColor = Colors.yellow;

  List<Icon> _tabImages = [
    Icon(Icons.home, size: 25.0, color: normalColor,),
    Icon(Icons.category, size: 25.0, color: normalColor,),
    Icon(null, size: 25.0, color: normalColor,),
    Icon(Icons.notifications, size: 25.0, color: normalColor,),
    Icon(Icons.person, size: 25.0, color: normalColor,),
  ];

  List<Icon> _tabSelectedImages = [
    Icon(Icons.home, size: 25.0, color: selectColor,),
    Icon(Icons.category, size: 25.0, color: selectColor,),
    Icon(null, size: 25.0, color: selectColor,),
    Icon(Icons.notifications, size: 25.0, color: selectColor,),
    Icon(Icons.person, size: 25.0, color: selectColor,),
  ];
  
  // BottomNaviItem
  List<BottomNavigationBarItem> _bottomNaviItems() {
    return [
      BottomNavigationBarItem(icon: getTabIcon(0), title: Text("首页")),
      BottomNavigationBarItem(icon: getTabIcon(1), title: Text('分类')),
      BottomNavigationBarItem(icon: getTabIcon(2), title: Text('发布')),
      BottomNavigationBarItem(icon: getTabIcon(3), title: Text('消息')),
      BottomNavigationBarItem(icon: getTabIcon(4), title: Text('我的')),
    ];
  }

  Icon getTabIcon(int index) {
    if (index == _tabIndex) {
      return _tabSelectedImages[index];
    } else {
      return _tabImages[index];
    }
  }
}

