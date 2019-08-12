
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FSCategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FSCategoryPageState();
  }
}

class _FSCategoryPageState extends State<FSCategoryPage> with AutomaticKeepAliveClientMixin {
  
  List<String> _categoryList = [
    "热门推荐","女装","美妆","手机数码","家用电器","生活百货","运动户外","整车/车品", 
    "游戏装备","家具/饰品","儿童玩具","宠物用品","园艺/农用","房屋租赁","女鞋","服饰配件",
    "男装","女装","箱包","技能服务","乐器",
  ];
  int _selectedCategoryIndex = 0;

  List<String> _itemList = [
    "小米","空气净化器","风扇","电视机","三星","冰箱","家庭影院","电热水器",
  ];
  List<String> _titleList = [
    "大家电","厨房电器","卫生间电器","客厅电器","我卧室电器"
  ];

  //List<String>

  @override
  bool get wantKeepAlive => true;
  
  @override
  void initState() {
    super.initState();
    print("Init Cagegory page");
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("分类"),
        elevation: 0,
      ),
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return Row(
      children: <Widget>[
        _buildCategoryListWidget(),
        _buildCategoryGridWidget()
      ],
    );
  }

  // left category list 
  Widget _buildCategoryListWidget() {
    return Container(
      width: 100,
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 0.8,
            color: Colors.grey[300],
          )
        )
      ),
      child: ListView.builder(
        itemCount: _categoryList.length,
        itemExtent: 50,
        itemBuilder: (BuildContext buildContext, int index) {
          return _buildCategoryListItem(index);
        }   
      ),
    );
  }
  
  Widget _buildCategoryListItem(int index) {
    List<Widget> _list = [];

    if (index == _selectedCategoryIndex) {
      _list.add( 
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 4,
            height: 30,
            color: Colors.yellow,
          ),
        ),
      );
    }
      
    _list.add(
      Text(
        _categoryList[index],
        style: TextStyle(
          color: _selectedCategoryIndex == index ? Colors.black : Colors.grey,
        ),
      )
    );

    return FlatButton(
      onPressed: () {
        setState(() {
          _selectedCategoryIndex = index;
        });
      },
      splashColor: Colors.transparent,
      padding: EdgeInsets.all(0),
        child: Stack(
          alignment: Alignment.center,
          children: _list,
        )
    );
  }

  // right category grid 
  Widget _buildCategoryGridWidget() {
    return Expanded(
      child: Container(
        color: Colors.white,
        child: CustomScrollView(
          slivers: <Widget>[
            _buildCategoryGridTitle(_categoryList[_selectedCategoryIndex]),
            _buildCategoryGirdView(_itemList),

            _buildCategoryGridTitle(_titleList[0]),
            _buildCategoryGirdView(_itemList),
            
            _buildCategoryGridTitle(_titleList[1]),
            _buildCategoryGirdView(_itemList),
            
            _buildCategoryGridTitle(_titleList[2]),
            _buildCategoryGirdView(_itemList),
          ],
        ),
      )
    );
  }

  Widget _buildCategoryGridTitle(String title) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black
          )
        ),
      )
    );
  }

  Widget _buildCategoryGirdView(List datas) {
    return SliverGrid(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      delegate: SliverChildBuilderDelegate(
        (BuildContext buildContext, int index) {
          return GestureDetector(
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  CachedNetworkImage(
                    width: 64,
                    height: 64,
                    placeholder: (BuildContext context, String p) {
                      return CircularProgressIndicator();
                    },
                    imageUrl: "https://cataas.com/cat",
                    errorWidget: (BuildContext context, String error, Object obj) {
                      return Icon(
                        Icons.error
                      );
                    }
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    datas[index],
                  )

                ],
              ),
            ),
          );
        },
        childCount: datas.length
      ),
    );
  }

}