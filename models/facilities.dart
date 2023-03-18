class Facilities {
  int ID;
  String schoolID;
  int roomArea;
  String roomName;
  Facilities(
      {required this.ID,
      required this.schoolID,
      required this.roomArea,
      required this.roomName});

  Map<String, Object?> toJson() {
    return {
      'ID': ID,
      'schoolID': schoolID,
      'roomArea': roomArea,
      'roomName': roomName
    };
  }

  factory Facilities.fromJson(Map<String, dynamic> json) {
    return Facilities(
        ID: int.parse(json['ID']),
        schoolID: json['schoolID'].toString(),
        roomArea: int.parse(json['roomArea']),
        roomName: json['roomName'].toString());
  }

  @override
  String toString() {
    return '''Facilities(
                ID:$ID,
schoolID:$schoolID,
roomArea:$roomArea,
roomName:$roomName
    ) ''';
  }
}
