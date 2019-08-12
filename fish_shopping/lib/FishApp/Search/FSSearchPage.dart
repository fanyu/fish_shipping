

import 'package:fish_shopping/FishApp/Config/FishConfig.dart';
import 'package:fish_shopping/FishApp/Search/FSMenuPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FSSearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FSSearchPageState();
  }
}

class _FSSearchPageState extends State<FSSearchPage> {

  List<String> _historyDatas = [];
  List<String> _hotDatas = [];
  String _selectedMenu = "宝贝";
  TextEditingController _editingController;
  
  bool isSearching = false;
  bool lastIsSearching = false;

  // search list 
  List<String> _searchResults = [];
  List<String> _mockSearchDatas = [];

  @override
  void initState() {
    super.initState();

    _historyDatas = ["nike", "摄像头", "Amplifi", "3M软水机", "鹿客猫眼", "争先", 
      "苹果数据线", "充电器", "Mac电脑笔记本", "小米电动车"];
    _hotDatas = ["airpods 耳机塞", "airpods2 壳", "路由器mesh", "路由器 家用", 
      "水槽沥水架", "小天才旗舰店", "主动式电容笔", "杨丞琳同款", "气味杯"];
    
    _mockSearchDatas.addAll(_historyDatas);
    _mockSearchDatas.addAll(_hotDatas);

    _editingController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: buildSearchBar(),
      ),
      body: buildBody(),
    );
  }

  // actions 
  _onTapDeleteHistory() {
    setState(() {
      _historyDatas.clear();
    });
  }

  _onTapTag(String tag) {
    print(tag);
  }

  _onTapMenu() async {
    // final result = await Navigator.of(context, rootNavigator: true).push(
    //    PageRouteBuilder( // 无动画的切换
    //     opaque: false,
    //     transitionDuration: Duration(microseconds: 0),
    //     pageBuilder: (context, anim1, anim2) => FSMenuPage(),
    //   ),
    // );

    // if (result != null) {
    //    setState(() {
    //     _selectedMenu = result;
    //   });
    // }
    
    FSMenuPage.show(context, (String menu) {
      setState(() {
        _selectedMenu = menu;
      });
    });
  }

  _filterSearchResults(String query) {
    List<String> dummySearchList = [];

    _mockSearchDatas.forEach((item){
      if (item.contains(query)) {
        dummySearchList.add(item);
      }
    });

    setState(() {
      _searchResults.clear();
      _searchResults.addAll(dummySearchList);
    });
  }

  // build UI 

  Widget buildBody() {
    if (isSearching) {
      return buildSearchResultWidget();
    } else { 
      return buildSearchHistory();
    }
  }

  Widget buildSearchResultWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
      color: Colors.white,
      child: ListView.builder(
        itemCount: _searchResults.length,
        itemExtent: 50,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _searchResults[index],
                  style: TextStyle(
                    color: Colors.black
                  )
                ),
                SizedBox(height: 7,),
                Divider(color: Colors.grey[350],),
              ],
            ),
          );
        },
      )
    );
  }

  Widget buildSearchHistory() {
    List<Widget> children = [];
    if (_historyDatas.isNotEmpty) {
      children.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "历史搜索",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
                fontWeight: FontWeight.w400
              )
            ),
            GestureDetector(
              onTap: () {
                _onTapDeleteHistory();
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.grey
              ),
              
            )
          ],
        )
      );

      children.add(
        SizedBox(height: 15,)
      );

      children.add(
        buildTagsWidget(_historyDatas),
      );

      children.add(
        SizedBox(height: 25,)
      );
    }

    children.add(
      Text(
        "大家都在搜",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          fontWeight: FontWeight.w400
        )
      ),
    );

    children.add(
      SizedBox(height: 15,)
    );

    children.add(
        buildTagsWidget(_hotDatas)
    );

    return Container(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
      color: Colors.white,
      child: ListView(
        children: children,
      ),
    );
  }

  Widget buildTagsWidget(List<String> tags) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: tags.map((String tag) {
        return GestureDetector(
          onTap: () {
            _onTapTag(tag);
          },
          child: Container(
            height: 34,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
            decoration: BoxDecoration(
              color: fishGreyColor,
              borderRadius: BorderRadius.circular(4)
            ),
            child: Text(
              tag,
              textAlign: TextAlign.center,
            ),
          ),
        );

        // return GestureDetector(
        //   onTap: () {
        //     _onTapTag(tag);
        //   },
        //   child: Chip(
        //     shape: RoundedRectangleBorder(
        //       borderRadius: BorderRadius.all(Radius.circular(4))
        //     ),
        //     backgroundColor: fishGreyColor,
        //     label: Text(
        //       tag,
        //     ),
        //   )
        // );
      }).toList(),
    );
  }

  Widget buildSearchBar() {
    return Row(
      children: <Widget>[
        SizedBox(width: 20,),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: fishGreyColor,
              borderRadius: BorderRadius.all(Radius.circular(4)),
            ),
            child: Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    _onTapMenu();
                  },
                  child: Text(
                    _selectedMenu,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 15,
                      fontWeight: FontWeight.w300
                    )
                  ),
                ),

                Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black,
                  size: 20,
                ),
                
                // input textfield 
                Expanded(
                  child: TextField(
                    controller: _editingController,
                    autofocus: true,
                    decoration: InputDecoration.collapsed(
                      hintText: "iPhoneXr手机壳",
                      hintStyle: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 14,
                        fontWeight: FontWeight.w500
                      )
                    ),
                    onChanged: (String input) {
                      if (input.isEmpty) {
                        isSearching = false;
                      } else {
                        isSearching = true;
                        _filterSearchResults(input);
                      }
                      // update body 防止多次刷新
                      if (isSearching != lastIsSearching) {
                        lastIsSearching = isSearching;
                        setState(() {});
                      }
                    },
                  ),
                ),
                
              ],
            ),
          ),
        ),
        
        SizedBox(
          width: 70,
          child: FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            padding: EdgeInsets.all(0),
            color: Colors.transparent,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: Text(
              "取消",
              style: TextStyle( 
                color: Colors.grey[700],
                fontSize: 18,
                fontWeight: FontWeight.w400
              ),
            ),
          )
        ),
      ],
    );
  }

}