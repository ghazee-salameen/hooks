import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hook/models/facilities.dart';
import 'package:hook/models/lcd.dart';

import '../services/apiservice.dart';
import '../utils/style.dart';

class FacilitiesMenu extends HookWidget {
  FacilitiesMenu({super.key, required this.schoolID});
  String schoolID;

  List<Facilities> facilitess = [];
  ApiServices apiServices = ApiServices();
  Facilities? facilities;

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AddNewFacilities(
            schoolId: schoolID,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Future<String> _fetchData() async {
      String result = ' Done';
      int count = await apiServices.getCountAll(schoolID, 'facilitiesTbl');
      //print('fetch:  ${count.toString()}');
      if (count > 0) {
        facilitess =
            await apiServices.getfromfacilities(schoolID, 'facilitiesTbl');
        Future.delayed(const Duration(seconds: 1));
        facilities = facilitess[0];
        if (kDebugMode) {
          print(facilities.toString());
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
            return AddNewFacilities(
              schoolId: schoolID,
            );
          });
    }

    final future = useMemoized(_fetchData);
    final snapshot = useFuture(future);

    print(schoolID);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'بيانات مرافق المدرسة ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              PopupMenuButton(
                  child: const Icon(Icons.add),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'add',
                        child: Text('اضافة مرفق جديد '),
                      ),
                    ];
                  },
                  onSelected: (String value) {
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
            : facilitess.isNotEmpty
                ? ListView.builder(
                    itemCount: facilitess.length,
                    itemBuilder: (context, index) => FacilitiesCard(
                      facilities: facilitess[index],
                    ),
                  )
                : const Center(
                    child: Text('Data Not Found'),
                  ),
      ),
    );
  }
}

class FacilitiesCard extends StatelessWidget {
  FacilitiesCard({super.key, required this.facilities});
  Facilities facilities;

  ApiServices apiServices = ApiServices();
  Future<void> _deletelcd(Facilities facilities) async {
    print(facilities.schoolID);
    String result = await apiServices.deletefacilities(facilities.ID);
    if (kDebugMode) {
      print(result);
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    print(facilities.ID.toString());
    return showDialog(
        context: context,
        builder: (context) {
          return EditDialog(
            facilities: facilities,
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
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //       builder: (context) => CopierPage(copier: widget.copier)),
            // );
            print('');
          },
          leading: const Icon(
            Icons.tv,
            color: Colors.amber,
          ),
          title: Text(
            facilities.roomName,
            style: textstyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text(
              'مساحة الغرفة: ${facilities.roomArea.toString()}',
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
              value == 'delete'
                  ? _deletelcd(facilities)
                  : _displayTextInputDialog(context);
            },
          ),
        ),
      ),
    );
  }
}

class EditDialog extends StatelessWidget {
  EditDialog({super.key, required this.facilities});
  Facilities facilities;

  ApiServices apiServices = ApiServices();
  void _savedata(Facilities facilities) async {
    if (kDebugMode) {
      print(facilities.toString());
    }
    var result = await apiServices.updatefacilitiesData(
        facilities.toJson(), facilities.ID);
    if (kDebugMode) {
      print(facilities.ID);
      print(result);
    }
  }

  TextEditingController _areaController = TextEditingController();
  TextEditingController _nameController = TextEditingController();

  String? codeDialog;
  String? valueText;
  final List<String> _facilitiesListName = [
    ' مكتبة',
    'مختبر علوم  ',
    'مختبر حاسوب  ',
    ' مختبر تكنولوجيا',
    'غرفة مصادر ',
    'أخرى',
  ];

  @override
  Widget build(BuildContext context) {
    facilities = facilities;
    _areaController.text = facilities.roomArea.toString();
    _nameController.text = facilities.roomName;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 600,
        child: AlertDialog(
          title: const Text('بيانات  مرافق المدرسة'),
          content: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'نوع المرفق  ',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _facilitiesListName,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        scrollbarProps: ScrollbarProps(thickness: .2),
                        //comment this if you want that the items do not takes all available height
                        constraints: BoxConstraints.tightFor(),
                      ),
                      onChanged: (value) {
                        print(value);

                        _nameController.text = value!;

                        facilities.roomName = _nameController.text;
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                textDirection: TextDirection.rtl,
                onChanged: (value) {
                  valueText = value;

                  facilities.roomArea = int.parse(value);
                },
                controller: _nameController,
                decoration: const InputDecoration(
                  label: Text(
                    'نوع المرفق  ',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
              TextField(
                textDirection: TextDirection.rtl,
                onChanged: (value) {
                  valueText = value;

                  facilities.roomArea = int.parse(value);
                },
                controller: _areaController,
                decoration: const InputDecoration(
                  label: Text(
                    'مساحة المرفق  ',
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
                _savedata(facilities);
                print(facilities.ID);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewFacilities extends StatelessWidget {
  AddNewFacilities({super.key, required this.schoolId});
  String schoolId;

  Facilities facilities = Facilities(
    ID: 0,
    schoolID: '',
    roomArea: 0,
    roomName: '',
  );

  ApiServices apiServices = ApiServices();
  void _savedata(Facilities facilities) async {
    facilities.schoolID = schoolId;
    print(facilities.toString());
    var result = await apiServices.addfacilitiesData(facilities.toJson());
    print(result);
  }

  String? codeDialog;
  String? valueText;
  final List<String> _facilitiesListName = [
    ' مكتبة',
    'مختبر علوم  ',
    'مختبر حاسوب  ',
    ' مختبر تكنولوجيا',
    'غرفة مصادر ',
    'أخرى',
  ];
  TextEditingController _nameController = TextEditingController();
  TextEditingController _areaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? labelTextStyle = Theme.of(context).textTheme.labelLarge;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 600,
        child: AlertDialog(
          title: const Text('بيانات المرفق الجديد'),
          content: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'نوع المرفق ',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _facilitiesListName,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        scrollbarProps: ScrollbarProps(thickness: .2),
                        //comment this if you want that the items do not takes all available height
                        constraints: BoxConstraints.tightFor(),
                      ),
                      onChanged: (value) {
                        print(value);

                        _nameController.text = value!;

                        facilities.roomName = _nameController.text;
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                onChanged: (value) {
                  valueText = value;

                  facilities.roomArea = int.parse(value);
                },
                controller: _areaController,
                decoration: const InputDecoration(
                    label: Text(
                  "مساحة الغرفة ",
                  style: TextStyle(color: Colors.blueAccent),
                )),
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
                //facilities.schoolID = schoolId;
                _savedata(facilities);

                print(facilities.schoolID);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
