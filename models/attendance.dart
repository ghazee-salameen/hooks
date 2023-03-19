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
      ID: int.parse(json['ID']),
      schoolID: json['schoolID'].toString(),
      attendanceType: json['attendanceType'].toString(),
      attendanceExist: json['attendanceExist'] == false ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'schoolID': schoolID,
      'attendanceType': attendanceType,
      'attendanceExist': attendanceExist.toString()
    };
  }
}
