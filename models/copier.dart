class CopierColumnName {
  static const String ID = 'ID';
  static const String schoolId = 'schoolId';
  static const String copierType = 'copierType';
  static const String copierCo = 'copierCo';
  static const String copierModel = 'copierModel';
  static const String copierMaintenance = 'copierMaintenance';
  static const String copierOwner = 'copierOwner';
  static const String counter = 'counter';
}

class Copier {
  int? ID;
  String schoolId;
  String copierType;
  String copierCo;
  String copierModel;
  bool copierMaintenance;
  bool copierOwner;
  int counter;

  Copier(
      {this.ID,
      required this.schoolId,
      required this.copierType,
      required this.copierCo,
      required this.copierModel,
      required this.copierMaintenance,
      required this.copierOwner,
      required this.counter});
  factory Copier.fromJson(Map<String, dynamic> json) {
    return Copier(
        ID: int.parse(json['ID']),
        schoolId: json['schoolId'].toString(),
        copierType: json['copierType'].toString(),
        copierCo: json['copierCo'].toString(),
        copierModel: json['copierModel'].toString(),
        copierMaintenance: json['copierMaintenance'] == false ? false : true,
        copierOwner: json['copierOwner'] == false ? false : true,
        counter: json['counter'] == null ? 0 : int.parse(json['counter']));
  }
  Map<String, dynamic> toMap() {
    return {
      CopierColumnName.schoolId: schoolId,
      CopierColumnName.copierType: copierType,
      CopierColumnName.copierCo: copierCo,
      CopierColumnName.copierModel: copierModel,
      CopierColumnName.copierMaintenance: copierMaintenance.toString(),
      CopierColumnName.copierOwner: copierOwner.toString(),
      CopierColumnName.counter: counter.toString(),
    };
  }

  @override
  String toString() {
    return '''

        ID: $ID,
        schoolID:$schoolId,
        copierType: $copierType,
      copierCo: $copierCo,
      copierModel: $copierModel,
      copierMaintenance: $copierMaintenance,
      copierOwner: $copierOwner,
    counter: $counter,
''';
  }
}
