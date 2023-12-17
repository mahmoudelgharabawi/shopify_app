class Ads {
  String? id;
  String? title;
  String? picture;

  Ads();

  Ads.fromJson(Map<String, dynamic> json, String docId) {
    id = docId;
    title = json['title'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['title'] = title;
    data['picture'] = picture;
    return data;
  }
}
