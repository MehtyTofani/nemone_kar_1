class StatesModel {
  StatesModel({
    this.stateId,
    this.stateName,
    this.isSelected
  });

  int? stateId;
  String? stateName;
  bool? isSelected;

  factory StatesModel.fromJson(Map<String, dynamic> json) => StatesModel(
    stateId: json["stateId"],
    stateName: json["stateName"],
    isSelected: false,
  );

  static List<StatesModel> listFromJson(List data) {
    return data.map((e) => StatesModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() => {
    "stateId": stateId,
    "stateName": stateName,
  };
}
