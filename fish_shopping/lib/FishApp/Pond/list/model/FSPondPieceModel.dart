
class FSPondPieceModel {
  String pondName;
  String userAvatar;
  String userName;
  String content;
  String topic;
  List<FSPondPiecePicModel> pics;
  String hotComment;
  String hotLikeCount;
  String commentCount;
  String likeCount;
  bool liked;

  FSPondPieceModel.fromJSON(Map data) {
    pondName = data['pondName'];
    userAvatar = data['userAvatar'];
    userName = data['userName'];
    content = data['content'];
    topic = data['topic'];
    hotComment = data['hotComment'];
    hotLikeCount = data['hotLikeCount'];
    commentCount = data['commentCount'];
    likeCount = data['likeCount'];
    liked = data['liked'];

    if (data['topic'] != null) {
      pics = (data['pics'] as List).map((i) =>  FSPondPiecePicModel.fromJSON(i)).toList();
    }
  }
}

class FSPondPiecePicModel {
  String url;
  double width;
  double height;

  FSPondPiecePicModel.fromJSON(Map data) {
    url = data['url'];
    width = data['width'];
    height = data['height'];
  }
}