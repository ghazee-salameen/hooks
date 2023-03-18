class WirelessModel {
  int ID;
  String schoolID;
  String deviceType;
  String deviceModel;
  int deviceCounter;
  String deviceSource;
  WirelessModel(
      {required this.ID,
      required this.schoolID,
      required this.deviceType,
      required this.deviceModel,
      required this.deviceCounter,
      required this.deviceSource});

  Map<String, Object?> toJson() {
    return {
      'ID': ID,
      'schoolID': schoolID,
      'deviceType': deviceType,
      'deviceModel': deviceModel,
      'deviceCounter': deviceCounter,
      'deviceSource': deviceSource
    };
  }

  factory WirelessModel.fromJson(Map<String, dynamic> json) {
    return WirelessModel(
      ID: int.parse(json['ID']),
      schoolID: json['schoolID'].toString(),
      deviceType: json['deviceType'].toString(),
      deviceModel: json['deviceModel'].toString(),
      deviceCounter: int.parse(json['deviceCounter']),
      deviceSource: json['deviceSource'].toString(),
    );
  }

  @override
  String toString() {
    return '''WirelessModel(
                ID:$ID,
schoolID:$schoolID,
deviceType:$deviceType,
deviceModel:$deviceModel,
deviceCounter:$deviceCounter,
deviceSource:$deviceSource
    ) ''';
  }
}
