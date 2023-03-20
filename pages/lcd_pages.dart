import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../models/lcd.dart';
import '../services/apiservice.dart';
import '../utils/style.dart';

class LcdPages extends HookWidget {
  LcdPages({super.key, required this.schoolID});
  String schoolID;

  List<Lcd> lcds = [];
  ApiServices apiServices = ApiServices();
  Lcd? lcd;

  @override
  Widget build(BuildContext context) {
    Future<String> _fetchData() async {
      String result = ' Done';
      int count = await apiServices.getCountAll(schoolID, 'lcdTbl');
      //print('fetch:  ${count.toString()}');
      if (count > 0) {
        lcds = await apiServices.getfromlcd(schoolID, 'lcdTbl');
        Future.delayed(const Duration(seconds: 1));
        lcd = lcds[0];
        if (kDebugMode) {
          print(lcd.toString());
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
            return AddNewLcd(
              schoolId: schoolID,
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
                'بيانات اجهزة العرض ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              PopupMenuButton(
                  child: const Icon(Icons.add),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'add',
                        child: Text('اضافة جهاز جديد '),
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
            : lcds.isNotEmpty
                ? ListView.builder(
                    itemCount: lcds.length,
                    itemBuilder: (context, index) => LcdCard(
                      lcd: lcds[index],
                      index: index,
                    ),
                  )
                : const Center(
                    child: Text(' No Data Found'),
                  ),
      ),
    );
  }
}

class LcdCard extends StatelessWidget {
  LcdCard({super.key, required this.lcd, required this.index});
  Lcd lcd;
  int index;

  ApiServices apiServices = ApiServices();
  Future<void> _deletelcd(Lcd lcd) async {
    if (kDebugMode) {
      print(lcd.schoolId);
    }

    String result = await apiServices.deleteLcd(lcd.ID!);
    if (kDebugMode) {
      print(result);
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    if (kDebugMode) {
      print(lcd.ID.toString());
    }
    return showDialog(
        context: context,
        builder: (context) {
          return EditDialog(
            lcd: lcd,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        color: index.isOdd ? Colors.blue[800] : Colors.amber[800],
        child: ListTile(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //       builder: (context) => CopierPage(copier: widget.copier)),
            // );
            if (kDebugMode) {
              print('');
            }
          },
          leading: const Icon(
            Icons.tv,
            color: Colors.amber,
          ),
          title: Text(
            lcd.lcdType,
            style: textstyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text(
              lcd.lcdModel,
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
                  ? showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("تنبيه"),
                        content: const Text("هل أنت متأكد من عملية الحذف"),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              _deletelcd(lcd);
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              color: Colors.green,
                              padding: const EdgeInsets.all(14),
                              child: const Text("okay"),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                            },
                            child: Container(
                              color: Colors.green,
                              padding: const EdgeInsets.all(14),
                              child: const Text("cancel"),
                            ),
                          ),
                        ],
                      ),
                    ) //
                  : _displayTextInputDialog(context);
            },
          ),
        ),
      ),
    );
  }
}

class EditDialog extends StatelessWidget {
  EditDialog({super.key, required this.lcd});
  Lcd lcd;
  ApiServices apiServices = ApiServices();
  void _savedata(Lcd lcd) async {
    var result = await apiServices.updateLcdData(lcd.toMap(), lcd.ID!);
    if (kDebugMode) {
      print(result);
    }
  }

  //  lcd = Lcd(
  //   schoolId: '',
  //   lcdType: '',
  //   lcdModel: '',
  //   lcdDate: '',
  // );

  TextEditingController _typeController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  String? codeDialog;
  String? valueText;
  final List<String> _lcdListName = [
    'overhead projector',
    'جهاز عرض عادي',
    'جهاز عرض تفاعلي',
    'لوح ذكي',
    'شاشة تفاعلية',
    'شاشة عرض ذكية',
    'شاشة عرض',
    'أخرى',
  ];
  @override
  Widget build(BuildContext context) {
    lcd = lcd;
    _typeController.text = lcd.lcdType;
    _modelController.text = lcd.lcdModel;
    _dateController.text = lcd.lcdDate;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 600,
        child: AlertDialog(
          title: const Text('بيانات جهاز العرض'),
          content: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'نوع الجهاز  ',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _lcdListName,
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

                        lcd.lcdType = _typeController.text;
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                textDirection: TextDirection.rtl,
                onChanged: (value) {
                  valueText = value;

                  lcd.lcdType = value;
                },
                controller: _typeController,
                decoration: const InputDecoration(
                  label: Text(
                    'نوع الجهاز ',
                    style: TextStyle(color: Colors.blueAccent),
                  ),
                ),
              ),
              TextField(
                textDirection: TextDirection.rtl,
                onChanged: (value) {
                  valueText = value;

                  lcd.lcdModel = value;
                },
                controller: _modelController,
                decoration: const InputDecoration(
                    label: Text(
                  "موديل الجهاز",
                  style: TextStyle(color: Colors.blueAccent),
                )),
              ),
              TextField(
                textDirection: TextDirection.rtl,
                controller: _dateController,
                decoration: const InputDecoration(
                    label: Text(
                  '  تاريخ الادخال',
                  style: TextStyle(color: Colors.blueAccent),
                )),
                onSubmitted: (value) {
                  valueText = value;
                  lcd.lcdDate = value;
                  // widget.copier.copierCo = _companyController.text;
                },
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
                _savedata(lcd);
                print(lcd.ID);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewLcd extends StatelessWidget {
  AddNewLcd({super.key, required this.schoolId});
  String schoolId;
  TextEditingController _typeController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _counterController = TextEditingController();
  TextEditingController _mcounterController = TextEditingController();
  Lcd lcd = Lcd(schoolId: '', lcdType: '', lcdModel: '', lcdDate: '');
  ApiServices apiServices = ApiServices();
  void _savedata(Lcd lcd) async {
    lcd.schoolId = schoolId;

    var result = await apiServices.addLcdData(lcd.toMap());
    print(result);
  }

  String? codeDialog;
  String? valueText;
  final List<String> _lcdListName = [
    'overhead projector',
    'جهاز عرض عادي',
    'جهاز عرض تفاعلي',
    'لوح ذكي',
    'شاشة تفاعلية',
    'شاشة عرض ذكية',
    'شاشة عرض',
    'أخرى',
  ];
  @override
  Widget build(BuildContext context) {
    TextStyle? labelTextStyle = Theme.of(context).textTheme.labelLarge;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 600,
        child: AlertDialog(
          title: const Text('بيانات جهاز العرض'),
          content: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'نوع الجهاز ',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _lcdListName,
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

                        lcd.lcdType = _typeController.text;
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                onChanged: (value) {
                  valueText = value;

                  lcd.lcdModel = value;
                },
                controller: _modelController,
                decoration: const InputDecoration(
                    label: Text(
                  "موديل الجهاز",
                  style: TextStyle(color: Colors.blueAccent),
                )),
              ),
              TextField(
                controller: _companyController,
                decoration: const InputDecoration(
                    label: Text(
                  '  تاريخ الادخال',
                  style: TextStyle(color: Colors.blueAccent),
                )),
                onChanged: (value) {
                  lcd.lcdDate = value;
                },
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
                lcd.schoolId = schoolId;
                _savedata(lcd);

                print(lcd.schoolId);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
