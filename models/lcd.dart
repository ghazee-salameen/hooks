class LcdColumnsName {
  static const String ID = 'ID';
  static const String schoolId = 'schoolID';
  static const String lcdType = 'lcdType';
  static const String lcdModel = 'lcdModel';
  static const String lcdDate = 'lcdDate';
}

class Lcd {
  int? ID;
  String schoolId;
  String lcdType;
  String lcdModel;
  String lcdDate;

  Lcd({
    this.ID,
    required this.schoolId,
    required this.lcdType,
    required this.lcdModel,
    required this.lcdDate,
  });

  factory Lcd.fromJson(Map<String, dynamic> json) {
    return Lcd(
      ID: int.parse(json['ID']),
      schoolId: json['schoolID'].toString(),
      lcdType: json['lcdType'].toString(),
      lcdModel: json['lcdModel'].toString(),
      lcdDate: json['lcdDate'].toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      LcdColumnsName.ID: ID,
      LcdColumnsName.schoolId: schoolId,
      LcdColumnsName.lcdType: lcdType,
      LcdColumnsName.lcdModel: lcdModel,
      LcdColumnsName.lcdDate: lcdDate,
    };
  }
}
