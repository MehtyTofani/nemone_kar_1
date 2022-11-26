import 'package:get/get.dart';

class CategoryModel extends GetxController {
  CategoryModel({
    this.id,
    this.name,
    this.icon,
    this.banner,
    this.selected,
    this.hasSub,
    this.hasGender,
    this.hasBrand,
    this.hasPetName,
  });

  int? id;
  String? name;
  String? icon;
  String? banner;
  bool? hasSub;
  bool? hasGender;
  bool? hasBrand;
  bool? hasPetName;
  RxBool? selected = false.obs;

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json["id"],
    name: json["name"],
    icon: json["icon"],
    banner: json["banner"],
    hasSub: json["hasSub"],
    hasGender: json["hasGender"],
    hasBrand: json["hasBrand"],
    hasPetName: json["hasPetName"],
    selected: false.obs,
  );

  static List<CategoryModel> listFromJson(List data) {
    return data.map((e) => CategoryModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "icon": icon,
    "banner": banner,
    "hasSub": hasSub,
    "hasGender": hasGender,
    "hasBrand": hasBrand,
    "hasPetName": hasPetName,
  };
}
