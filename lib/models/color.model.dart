class ColorData {
  String? name;
  String? code;

  ColorData();

  ColorData.fromJson(Map<String, dynamic> data) {
    name = data['name'];
    code = data['code'];
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "code": code,
    };
  }
}
