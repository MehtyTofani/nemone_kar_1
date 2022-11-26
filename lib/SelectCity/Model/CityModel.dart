class CityModel {
  CityModel({
    this.id,
    this.name,
  });

  int? id;
  String? name;
  bool isSelected = false;

  factory CityModel.fromJson(Map<String, dynamic> json) => CityModel(
    id: json["id"],
    name: json["name"],
  );


  static List<CityModel> listFromJson(List data) {
    return data.map((e) => CityModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
