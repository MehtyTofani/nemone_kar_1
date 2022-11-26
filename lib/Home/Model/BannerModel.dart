class BannerModel {
  BannerModel({
    this.bannerId,
    this.bannerName,
    this.bannerImage,
    this.bannerLink,
  });

  int? bannerId;
  String? bannerName;
  String? bannerImage;
  String? bannerLink;

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        bannerId: json["banner_id"],
        bannerName: json["banner_name"],
        bannerImage: json["banner_image"],
        bannerLink: json["banner_link"],
      );

  static List<BannerModel> listFromJson(List data) {
    return data.map((e) => BannerModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
        "banner_id": bannerId,
        "banner_name": bannerName,
        "banner_image": bannerImage,
        "banner_link": bannerLink,
      };
}
