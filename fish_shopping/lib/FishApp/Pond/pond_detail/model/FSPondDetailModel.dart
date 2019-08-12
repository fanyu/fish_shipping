

class FSPondDetailModel {
  String id;
  String avatar;
  String name;
  String hotCount;
  String topicCount;

  FSPondDetailModel.fromJSON(Map data) {
    id = data['id'];
    avatar = data['avatar'];
    name = data['name'];
    hotCount = data['hotCount'];
    topicCount = data['topicCount'];
  }
}