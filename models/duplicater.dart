// ignore: camel_case_types
class duplicaterColumnsName {
  static const String ID = 'ID';
  static const String schoolID = 'schoolID';
  static const String duplicaterType = 'duplicaterType';
  static const String duplicaterModel = 'duplicaterModel';
  static const String duplicaterDate = 'duplicaterDate';
  static const String mCounter = 'mCounter';
  static const String cCounter = 'cCounter';
}

class Duplicater {
  int? ID;
  String? schoolId;
  String? duplicaterType;
  String? duplicaterModel;
  String? duplicaterDate;
  int? mCounter;
  int? cCounter;

  Duplicater({
    this.ID,
    required this.schoolId,
    required this.duplicaterType,
    required this.duplicaterModel,
    required this.duplicaterDate,
    required this.mCounter,
    required this.cCounter,
  });

  factory Duplicater.fromJson(Map<String, dynamic> json) {
    return Duplicater(
      ID: int.parse(json['ID']),
      schoolId: json['schoolId'].toString(),
      duplicaterType: json['duplicaterType'].toString(),
      duplicaterModel: json['duplicaterModel'].toString(),
      duplicaterDate: json['duplicaterDate'].toString(),
      mCounter: json['mCounter'] == null ? 0 : int.parse(json['mCounter']),
      cCounter: json['cCounter'] == null ? 0 : int.parse(json['cCounter']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      duplicaterColumnsName.ID: ID.toString(),
      duplicaterColumnsName.schoolID: schoolId,
      duplicaterColumnsName.duplicaterType: duplicaterType,
      duplicaterColumnsName.duplicaterModel: duplicaterModel,
      duplicaterColumnsName.duplicaterDate: duplicaterDate,
      duplicaterColumnsName.mCounter: mCounter.toString(),
      duplicaterColumnsName.cCounter: cCounter.toString(),
    };
  }

  String toString() {
    return '''

        ID: $ID,
      schoolId: $schoolId,
      duplicaterType: $duplicaterType,
      duplicaterModel: $duplicaterModel,
      duplicaterDate: $duplicaterDate,
      mCounter: $mCounter,
      cCounter: $cCounter,
''';
  }
}
