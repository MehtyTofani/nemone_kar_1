class HomeAdsModel {
  HomeAdsModel({
    this.id,
    this.city,
    this.adTypeName,
    this.priceTypeId,
    this.priceTypeName,
    this.name,
    this.date,
    this.price,
    this.image,
  });

  int? id;
  String? city;
  List<String>? adTypeName;
  int? priceTypeId;
  String? priceTypeName;
  String? name;
  String? date;
  String? price;
  String? image;

  factory HomeAdsModel.fromJson(Map<String, dynamic> json) => HomeAdsModel(
    id: json["id"],
    city: json["city"],
    adTypeName: List<String>.from(json["adTypeName"].map((x) => x)),
    priceTypeId: json["priceTypeId"],
    priceTypeName: json["priceTypeName"],
    name: json["name"],
    date: json["date"].toString(),
    price: json["price"],
    image: json["image"],
  );

  static List<HomeAdsModel> listFromJson(List data){
    return data.map((e) => HomeAdsModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "adTypeName": List<dynamic>.from(adTypeName!.map((x) => x)),
    "priceTypeId": priceTypeId,
    "priceTypeName": priceTypeName,
    "name": name,
    "date": date,
    "price": price,
    "image": image,
  };
}
