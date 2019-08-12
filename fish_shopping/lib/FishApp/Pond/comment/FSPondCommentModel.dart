
class FSPondCommentModel {
  String userAvatar;
  String userName;
  String likeCount;
  bool liked;
  String date;
  String comment;
  List<FSPondCommentReplyModel> replys;

  FSPondCommentModel.fromJSON(Map data) {
    userAvatar = data['userAvatar'];
    userName = data['userName'];
    likeCount = data['likeCount'];
    liked = data['liked'];
    date = data['date'];
    comment = data['comment'];
    
    if (data['replys'] != null) {
      replys = (data['replys'] as List).map((i) => FSPondCommentReplyModel.fromJSON(i)).toList();
    }
  }
}

class FSPondCommentReplyModel {
  String userName;
  String comment;

  FSPondCommentReplyModel.fromJSON(Map data) {
    userName = data['userName'];
    comment = data['comment'];
  }
}