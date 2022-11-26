class AboutUsModel {
  AboutUsModel({
    this.infoMobile,
    this.infoAddress,
    this.infoEmail,
    this.rules,
    this.aboutUs,
  });

  String? infoMobile;
  String? infoAddress;
  String? infoEmail;
  String? rules;
  String? aboutUs;

  factory AboutUsModel.fromJson(Map<String, dynamic> json) => AboutUsModel(
    infoMobile: json["infoMobile"],
    infoAddress: json["infoAddress"],
    infoEmail: json["infoEmail"],
    rules: json["rules"],
    aboutUs: json["aboutUs"],
  );

  Map<String, dynamic> toJson() => {
    "infoMobile": infoMobile,
    "infoAddress": infoAddress,
    "infoEmail": infoEmail,
    "rules": rules,
    "aboutUs": aboutUs,
  };
}
