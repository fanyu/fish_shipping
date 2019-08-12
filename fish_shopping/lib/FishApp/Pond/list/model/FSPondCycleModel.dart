
class FSPondCycleModel {
  String url;
  String id;
  String type;

  FSPondCycleModel.fromJSON(Map data) {
    url = data['url'];
    id = data['id'];
    type = data['type'];
  }
}