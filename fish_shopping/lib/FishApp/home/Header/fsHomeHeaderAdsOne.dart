
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'FSHomeAdsModel.dart';

class FSHomeHeaderAdsOne extends StatelessWidget {

  final List<FSHomeAdsModel> _adsOne = [
    FSHomeAdsModel("逛同城", "37.9万在线", "https://cataas.com/cat"),
    FSHomeAdsModel("免费送", "37.9万宝贝", "https://cataas.com/cat"),
    FSHomeAdsModel("租房", "真实房东", "https://cataas.com/cat"),
    FSHomeAdsModel("闲鱼币", "签到拿超级大奖", "https://cataas.com/cat"),
  ];

  @override
  Widget build(BuildContext context) {
    //return gridStyleButNoVerticalLine();

    return Stack(
      children:[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: Column(
            children: <Widget>[
              buildRowWidget(0),  
              buildRowWidget(2),
              buildThirdRowWidget(),
            ],
          ),
        ),

        // h - line 
        Padding(
          padding: EdgeInsets.only(top: 54),
          child: Divider(),
        ),
        // h - line 
        Padding(
          padding: EdgeInsets.only(top: 116),
          child: Divider(),
        ),

        // 自己添加 v-line 
        // Padding(
        //   padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2 - 10),
        //   child: Container(
        //     height: 180,
        //     width: 1,
        //     color: Colors.red,
        //   )
        // )
      ]
    );
  }

  //  row 
  Widget buildRowWidget(int index) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, 4, 10, 0),
      child: IntrinsicHeight( // 为了显示 VerticalDivider
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildAdsItemWidget(_adsOne[index]),
            VerticalDivider(),
            buildAdsItemWidget(_adsOne[index + 1]),
        
          ],
        )
      )
    );
  }

  // third row 
  Widget buildThirdRowWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(width: 10,),

        Expanded(
          flex: 1,
          child: Text(
            "明星在闲鱼",
            softWrap: false,  // 不自动换行
            style: TextStyle(
              color: Colors.pink,
              fontSize: 18,
              fontWeight: FontWeight.bold
            )
          ),
        ),

        SizedBox(width: 10,),

        Expanded(
          flex: 2,
          child: Text(
            "杨幂:黑色靴子LV包包限量版本",
            softWrap: false,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500
            )
          )
        ),

        Expanded(
          flex: 1,
          child: 
          Container(
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomRight: Radius.circular(14)),
              image: DecorationImage(
                image: AssetImage("images/image_01.png"),
                fit: BoxFit.cover
              )
            )
          ),
        ),
      ],
    );
  }

  // item 
  Widget buildAdsItemWidget(FSHomeAdsModel model) {
    return Expanded(child: 
      Container(
        padding: EdgeInsets.fromLTRB(0, 6, 0, 6),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  model.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    color: Colors.black
                  )
                ),
                Text(
                  model.detail,
                  style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 15,
                    color: Colors.black54
                  )
                ),
              ],
            ), 
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: CachedNetworkImageProvider(model.imgUrl),
                ),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
            ),
          ],
        ),
      )
    );
  }

  // 实现方式二 
  Widget gridStyleButNoVerticalLine() {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(14)),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                child:  GridView(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 0,
                    mainAxisSpacing: 0,
                    childAspectRatio: 3,
                  ),
                  children: _adsOne.map( (FSHomeAdsModel model) {
                    return buildAdsItemWidget( model);
                  }).toList(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: Text(
                      "明星在闲鱼",
                      softWrap: false,  // 不自动换行
                      style: TextStyle(
                        color: Colors.pink,
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      )
                    ),
                  ),

                  SizedBox(width: 10,),

                  Expanded(
                    flex: 2,
                    child: Text(
                      "杨幂:黑色靴子LV包包限量版本",
                      softWrap: false,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500
                      )
                    )
                  ),

                  Expanded(
                    flex: 1,
                    child: 
                    Container(
                      height: 50,
                      //width: 50,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.white],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomCenter
                        ),
                        borderRadius: BorderRadius.only(bottomRight: Radius.circular(14)),
                        image: DecorationImage(
                          image: AssetImage("images/image_01.png"),
                          fit: BoxFit.cover
                        )
                      )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        Padding(
          padding: EdgeInsets.only(top: 60),
          child: Divider(),
        ),
        
        Padding(
          padding: EdgeInsets.only(top: 124),
          child: Divider(),
        ),

        Container(
          padding: EdgeInsets.only(left: 40),
          height: 100,
          width: 1,
          color: Colors.red,
        )

      ],
    );
  }
}