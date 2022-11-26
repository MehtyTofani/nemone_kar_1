class UserModel {
  UserModel({
    this.individualId,
    this.gender,
    this.firstName,
    this.lastName,
    this.mobile,
    this.stateId,
    this.stateName,
    this.cityId,
    this.cityName,
    this.cooperation,
    this.image,
    this.social,
    this.socialId,
    this.credit,
  });

  int? individualId;
  int? gender;
  String? firstName;
  String? lastName;
  String? mobile;
  int? stateId;
  String? stateName;
  int? cityId;
  String? cityName;
  int? cooperation;
  String? image;
  Social? social;
  int? socialId;
  int? credit;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    individualId: json["individual_id"],
    gender: json["gender"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobile: json["mobile"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    cityId: json["city_id"],
    cityName: json["city_name"],
    cooperation: json["cooperation"],
    image: json["image"],
    social: Social.fromJson(json["social"]),
    socialId: json["social_id"],
    credit: json["credit"],
  );

  Map<String, dynamic> toJson() => {
    "individual_id": individualId,
    "gender": gender,
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "state_id": stateId,
    "state_name": stateName,
    "city_id": cityId,
    "city_name": cityName,
    "cooperation": cooperation,
    "image": image,
    "social": social!.toJson(),
    "social_id": socialId,
    "credit": credit,
  };
}

class Social {
  Social({
    this.instagram,
    this.telegram,
    this.website,
    this.email,
  });

  String? instagram;
  String? telegram;
  String? website;
  String? email;

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    instagram: json["instagram"],
    telegram: json["telegram"],
    website: json["website"],
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "instagram": instagram,
    "telegram": telegram,
    "website": website,
    "email": email,
  };
}
