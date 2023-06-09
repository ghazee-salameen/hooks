class PrinterColumnName {
  static const String ID = 'ID';
  static const String schoolId = 'schoolID';
  static const String printerType = 'printerType';
  static const String printerModel = 'printerModel';
  static const String printerDate = 'printerDate';
}

class Printer {
  int? ID;
  String schoolId;
  String printerType;
  String printerModel;
  String printerDate;

  Printer(
      {this.ID,
      required this.schoolId,
      required this.printerType,
      required this.printerModel,
      required this.printerDate});

  factory Printer.fromJson(Map<String, dynamic> json) {
    return Printer(
        ID: int.parse(json['ID']),
        schoolId: json['schoolID'],
        printerType: json['printerType'].toString(),
        printerModel: json['printerModel'].toString(),
        printerDate: json['printerDate'].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      PrinterColumnName.schoolId: schoolId,
      PrinterColumnName.printerType: printerType,
      PrinterColumnName.printerModel: printerModel,
      PrinterColumnName.printerDate: printerDate,
    };
  }

  String toString() {
    return '''
 ID: $ID,
        schoolId: $schoolId,
        printerType: $printerType,
        printerModel: $printerModel,
        printerDate: $printerDate,

''';
  }
}
