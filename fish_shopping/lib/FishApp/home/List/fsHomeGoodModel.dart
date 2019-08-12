
class FHHomeGoodModel {
  int id;
  int mediaType;       // pic: 1, video: 2
  double mediaHeight;
  double mediaWidth;
  String mediaURL;
  String detail;          // 商品描述
  double price;
  String avatarURL;
  String userName;
  int wantedCount;
  int tag;                //
  bool isCredictExeclent; 

  FHHomeGoodModel.fromJSON(Map data) {
    id = data['id'];
    mediaType = data['mediaType'];
    mediaHeight = data['mediaHeight'];
    mediaWidth = data['mediaWidth'];
    mediaURL = data['mediaURL'];
    mediaType = data['mediaType'];
    detail = data['detail'];
    price = data['price'];
    avatarURL = data['avatarURL'];
    userName = data['userName'];
    wantedCount = data['wantedCount'];
    tag = data['tag'];
    isCredictExeclent = data['isCredictExeclent'];
  }
}