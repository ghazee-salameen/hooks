import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hook/models/attendance.dart';

import '../services/apiservice.dart';
import '../utils/style.dart';

class AttendancePages extends HookWidget {
  AttendancePages({super.key, required this.schoolID});
  String schoolID;
  List<Attendance> attendances = [];
  ApiServices apiServices = ApiServices();
  Attendance? attendance;

  @override
  Widget build(BuildContext context) {
    Future<String> _fetchData() async {
      String result = ' Done';
      int count = await apiServices.getCountAll(schoolID, 'attendanceTbl');
      //print('fetch:  ${count.toString()}');
      if (count > 0) {
        attendances = await apiServices.getfromatt(schoolID, 'attendanceTbl');
        Future.delayed(Duration(seconds: 1));
        attendance = attendances[0];
        if (kDebugMode) {
          print(attendance.toString());
        }
      } else {
        result = 'no data foud';
      }

      return result;
    }

    Future<void> _displayTextInputDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AddNewAttendance(
              schoolID: schoolID,
            );
          });
    }

    final future = useMemoized(_fetchData);
    final snapshot = useFuture(future);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'بيانات ساعات الدوام',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              PopupMenuButton(itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 'add',
                    child: Text('اضافة ساعة جديدة'),
                  ),
                ];
              }, onSelected: (String value) {
                _displayTextInputDialog(context);
              }),
            ],
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 200, 231, 245),
        ),
        body: !snapshot.hasData
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : attendances.length > 0
                ? ListView.builder(
                    itemCount: attendances.length,
                    itemBuilder: (context, index) => AttendaceCard(
                      attendance: attendances[index],
                    ),
                  )
                : Center(child: Text('No Data Found')),
      ),
    );
  }
}

class AttendaceCard extends HookWidget {
  AttendaceCard({super.key, required this.attendance});
  Attendance attendance;
  ApiServices apiServices = ApiServices();

  Future<void> _deleteattendance(var attendance) async {
    String result = await apiServices.deleteAttendance(attendance.ID);
    if (kDebugMode) {
      print(result);
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    if (kDebugMode) {
      print(attendance.ID);
    }
    return showDialog(
        context: context,
        builder: (context) {
          return EditDialog(
            attendance: attendance,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        color: Colors.blue[800],
        child: ListTile(
          onTap: () {
            print(attendance.toString());
          },
          leading: const Icon(
            Icons.scanner,
            color: Colors.amber,
          ),
          title: Text(
            attendance.attendanceType,
            style: textstyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text(
              attendance.schoolID,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          trailing: PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                )
              ];
            },
            onSelected: (String value) {
              //print(widget.duplicater['ID']);
              value == 'delete'
                  ? _deleteattendance(attendance)
                  : _displayTextInputDialog(context);
            },
          ),
        ),
      ),
    );
  }
}

class EditDialog extends HookWidget {
  EditDialog({super.key, required this.attendance});
  Attendance attendance;
  ApiServices apiServices = ApiServices();
  void _savedata(Attendance attendance) async {
    var result = await apiServices.updateAttendanceData(
        attendance.toJson(), attendance.ID!);
    if (kDebugMode) {
      print(result);
    }
  }

  TextEditingController _typeController = TextEditingController();

  String? codeDialog;
  String? valueText;
  final List<String> _attendanceListName = [
    ' ZKT K14',
    ' JR780A',
    ' I clock',
    ' zk teco g3',
    ' Q2i',
    ' ZK -IK7-200',
    'ZK G3'
  ];
  @override
  Widget build(BuildContext context) {
    _typeController.text = attendance.attendanceType;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 600,
        child: AlertDialog(
          title: const Text('بيانات الساعة '),
          content: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'نوع الساعة  ',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _attendanceListName,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        scrollbarProps: ScrollbarProps(thickness: .2),
                        //comment this if you want that the items do not takes all available height
                        constraints: BoxConstraints.tightFor(),
                      ),
                      onChanged: (value) {
                        print(value);

                        _typeController.text = value!;

                        attendance.attendanceType = _typeController.text;
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                textDirection: TextDirection.rtl,
                onChanged: (value) {
                  valueText = value;

                  attendance.attendanceType = value;
                },
                controller: _typeController,
                decoration: const InputDecoration(
                  label: Text(
                    'نوع الساعة ',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                codeDialog = valueText;
                _savedata(attendance);
                print(attendance.ID);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewAttendance extends HookWidget {
  AddNewAttendance({super.key, required this.schoolID});
  String schoolID;
  Attendance attendance = Attendance(
    schoolID: '',
    attendanceType: '',
    attendanceExist: false,
  );

  ApiServices apiServices = ApiServices();
  void _savedata(Attendance attendance) async {
    attendance.schoolID = schoolID;

    var result = apiServices.addAttendanceData(attendance.toJson());
    print(result);
  }

  String? codeDialog;
  String? valueText;
  final List<String> _attendanceListName = [
    ' ZKT K14',
    ' JR780A',
    ' I clock',
    ' zk teco g3',
    ' Q2i',
    ' ZK -IK7-200',
    'ZK G3'
  ];
  TextEditingController _typeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 400,
        child: AlertDialog(
          scrollable: true,
          title: Text('بيانات الساعة '),
          content: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'نوع الساعة ',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _attendanceListName,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        scrollbarProps: ScrollbarProps(thickness: .2),
                        //comment this if you want that the items do not takes all available height
                        constraints: BoxConstraints.tightFor(),
                      ),
                      onChanged: (value) {
                        print(value);

                        _typeController.text = value!;

                        attendance.attendanceType = _typeController.text;
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('CANCEL'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                codeDialog = valueText;
                attendance.attendanceExist = true;
                attendance.schoolID = schoolID;
                _savedata(attendance);

                print(attendance.schoolID);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
