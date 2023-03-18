class Attendance {
  int? ID;
  String schoolID;
  String attendanceType;
  bool attendanceExist;

  Attendance(
      {this.ID,
      required this.schoolID,
      required this.attendanceType,
      required this.attendanceExist});

  factory Attendance.fromJson(Map<String, dynamic> json) {
    return Attendance(
      ID: json['ID'],
      schoolID: json['schoolID'],
      attendanceType: json['attendanceType'],
      attendanceExist: json['attendanceExist'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = ID;
    data['schoolID'] = schoolID;
    data['attendanceType'] = attendanceType;
    data['attendanceExist'] = attendanceExist;
    return data;
  }
}
