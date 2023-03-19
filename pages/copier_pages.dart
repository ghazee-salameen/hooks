import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';

import 'package:go_router/go_router.dart';
import 'package:hook/services/apiservice.dart';
import '../models/copier.dart';
import '../utils/style.dart';

class CopierMenu extends HookWidget {
  CopierMenu({super.key, required this.schoolID});
  String schoolID;
  List<Copier> copiers = [];
  ApiServices apiServices = ApiServices();

  @override
  Widget build(BuildContext context) {
    Future<String> _fetchData() async {
      String result = ' Done';
      int count = await apiServices.getCountAll(schoolID, 'copierTbl');
      //print('fetch:  ${count.toString()}');
      if (count > 0) {
        copiers = await apiServices.getfrom(schoolID, 'copierTbl');
        Future.delayed(Duration(seconds: 1));
        if (kDebugMode) {
          print(copiers[0].toString());
        }
        return 'Hello';
      } else {
        result = 'no data foud';
      }

      return result;
    }

    Future<void> _displayTextInputDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AddNewCopier(
              schoolID: schoolID,
            );
          });
    }

    final future = useMemoized(_fetchData);
    final snapshot = useFuture(future);
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'بيانات ماكنات التصوير',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              PopupMenuButton(itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    value: 'add',
                    child: Text('اضافة ماكنة جديدة'),
                  ),
                ];
              }, onSelected: (String value) {
                _displayTextInputDialog(context);
              }),
              IconButton(
                onPressed: () {
                  context.go('/menu/$schoolID');
                },
                icon: Icon(Icons.backspace),
              ),
            ],
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 200, 231, 245),
        ),
        body: !snapshot.hasData
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: ListView.builder(
                    itemCount: copiers.length,
                    itemBuilder: (context, index) {
                      return CopierCard(copier: copiers[index]);
                    }),
              ),
      ),
    );
  }
}

class CopierCard extends HookWidget {
  CopierCard({super.key, required this.copier});
  Copier copier;
  Future<void> _deletecopier(Copier copier) async {
    ApiServices apiServices = ApiServices();
    String result = await apiServices.deleteCopier(copier.ID!);
    print(result);
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            copier: copier,
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
            if (kDebugMode) {
              print('${copier.ID}');
            }
          },
          leading: const Icon(
            Icons.copy,
            color: Colors.amber,
          ),
          title: Text(
            copier.copierType,
            style: textstyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text(
              copier.copierModel,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          trailing: PopupMenuButton(itemBuilder: (context) {
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
          }, onSelected: (String value) async {
            value == 'edit'
                ? _displayTextInputDialog(context)
                : _deletecopier(copier);
          }),
        ),
      ),
    );
  }
}

class CustomDialog extends HookWidget {
  CustomDialog({super.key, required this.copier});
  Copier copier;

  TextEditingController _typeController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _counterController = TextEditingController();
  String? codeDialog;
  String? valueText;

  Color _contractColor = Colors.grey;
  String _contractText = 'يوجد عقد صيانة';
  String _not = 'لا';
  Color _propertyColor = Colors.grey;
  String _propertyText = 'مستأجرة';
  String _notp = '  ليست ';
  void _savedata(Copier copier, Map body) async {
    ApiServices apiServices = ApiServices();
    apiServices.updateCopierData(body, copier.ID!);
  }

  @override
  Widget build(BuildContext context) {
    final contractCheck = useState(false);
    final propertyCheck = useState(false);
    final firstvalue = useState(true);
    _typeController.text = copier.copierType;
    _modelController.text = copier.copierModel;
    _companyController.text = copier.copierCo;
    _counterController.text = copier.counter.toString();
    if (firstvalue.value) {
      contractCheck.value = copier.copierMaintenance == 0 ? false : true;
      propertyCheck.value = copier.copierOwner == 0 ? false : true;
    }
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 600,
        child: AlertDialog(
          title: const Text('بيانات ماكنة التصوير'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  valueText = value;
                  copier.copierType = value;
                },
                controller: _typeController,
                decoration: const InputDecoration(
                  label: Text('نوع ماكنة التصوير'),
                ),
              ),
              TextField(
                onChanged: (value) {
                  valueText = value;
                  copier.copierModel = value;
                },
                controller: _modelController,
                decoration: const InputDecoration(label: Text("موديل الماكنة")),
              ),
              TextField(
                controller: _companyController,
                decoration:
                    const InputDecoration(label: Text(' الشركة المزودة')),
                onChanged: (value) {
                  copier.copierCo = _companyController.text;
                },
              ),
              TextField(
                onChanged: (value) {
                  valueText = value;
                  copier.counter = value.isNotEmpty ? int.parse(value) : 0;
                },
                controller: _counterController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('عداد الماكنة'),
                ),
              ),
              Column(
                children: [
                  ListTile(
                    trailing: Icon(
                      Icons.computer,
                      color: contractCheck.value ? Colors.red : Colors.grey,
                    ),
                    textColor: contractCheck.value ? Colors.red : Colors.grey,
                    leading: Checkbox(
                      activeColor: Colors.white38,
                      shape: const CircleBorder(),
                      value: contractCheck.value,
                      onChanged: ((value) {
                        contractCheck.value = !contractCheck.value;

                        copier.copierMaintenance = contractCheck.value;
                        firstvalue.value = false;
                        if (kDebugMode) {
                          //print(value);
                          print('5 .  ${contractCheck.value}');
                        }
                      }),
                    ),
                    title: contractCheck.value
                        ? Text(_contractText)
                        : Text(_not + ' ' + _contractText),
                  ),
                  ListTile(
                    trailing: Icon(
                      Icons.my_library_books,
                      color: propertyCheck.value ? Colors.red : Colors.grey,
                    ),
                    textColor: propertyCheck.value ? Colors.red : Colors.grey,
                    leading: Checkbox(
                      activeColor: Colors.white38,
                      shape: const CircleBorder(),
                      value: propertyCheck.value,
                      onChanged: ((value) {
                        propertyCheck.value = !propertyCheck.value;
                        copier.copierOwner = propertyCheck.value;
                        firstvalue.value = false;
                      }),
                    ),
                    title: propertyCheck.value
                        ? Text(_propertyText)
                        : const Text('ملك المدرسة'),
                  ),
                ],
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
                Map body = {
                  "schoolID": "${copier.schoolId}",
                  "copierType": _typeController.text,
                  "copierCo": _companyController.text,
                  "copierModel": _modelController.text,
                  "copierMaintenance": contractCheck.value ? "1" : "0",
                  "copierOwner": propertyCheck.value ? "1" : "0",
                  "counter": _counterController.text
                };

                _savedata(copier, body);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewCopier extends HookWidget {
  AddNewCopier({super.key, required this.schoolID});
  String schoolID;
  Copier copier = Copier(
      ID: 0,
      schoolId: '',
      copierType: '',
      copierCo: '',
      copierModel: '',
      copierMaintenance: false,
      copierOwner: false,
      counter: 0);

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _counterController = TextEditingController();

  String? codeDialog;
  String? valueText;

  final Color _contractColor = Colors.grey;
  final String _contractText = 'يوجد عقد صيانة';
  final String _not = 'لا';

  final Color _propertyColor = Colors.grey;
  final String _propertyText = 'مستأجرة';
  final String _notp = '  ليست ';

  final List<String> _copiersListName = [
    'Kyocera',
    'Toshiba',
    'Samsung',
    'Konica',
    'Richo',
    'ather'
  ];

  @override
  Widget build(BuildContext context) {
    final contractCheked = useState(false);
    final propertyCheked = useState(false);

    void _savedata(Copier copier) async {
      copier.schoolId = schoolID;
      ApiServices apiServices = ApiServices();
      print(schoolID);
      Map body = {
        "schoolID": copier.schoolId,
        "copierType": _typeController.text,
        "copierCo": _companyController.text,
        "copierModel": _modelController.text,
        "copierMaintenance": propertyCheked.value ? "1" : "0",
        "copierOwner": contractCheked.value ? "1" : "0",
        "counter": _counterController.text
      };
      apiServices.addCopierData(body);
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 600,
        child: AlertDialog(
          title: const Text('بيانات ماكنة التصوير'),
          content: Column(
            children: [
              Row(
                children: [
                  Text('بيانات ماكنة التصوير'),
                  Expanded(
                    flex: 1,
                    child: Text(
                      'نوع ماكنة التصوير ',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _copiersListName,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        scrollbarProps: ScrollbarProps(thickness: .2),
                        //comment this if you want that the items do not takes all available height
                        constraints: BoxConstraints.tightFor(),
                      ),
                      onChanged: (value) {
                        _typeController.text = value!;

                        copier.copierType = value;
                        if (kDebugMode) {
                          print(value);
                          print('1 .  ${copier.copierType}');
                        }
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                onChanged: (value) {
                  valueText = value;

                  copier.copierModel = value;
                  if (kDebugMode) {
                    print(value);
                    print('2 .  ${copier.copierModel}');
                  }
                },
                controller: _modelController,
                decoration: const InputDecoration(label: Text("موديل الماكنة")),
              ),
              TextField(
                controller: _companyController,
                decoration:
                    const InputDecoration(label: Text(' الشركة المزودة')),
                onChanged: (value) {
                  // widget.copier.copierCo = _companyController.text;

                  copier.copierCo = value;
                  if (kDebugMode) {
                    print(value);
                    print('3 .  ${copier.copierCo}');
                  }
                },
              ),
              TextField(
                onChanged: (value) {
                  valueText = value;

                  copier.counter = value.isNotEmpty ? int.parse(value) : 0;
                  if (kDebugMode) {
                    print(value);
                    print('4 .  ${copier.counter}');
                  }
                },
                controller: _counterController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('عداد الماكنة'),
                ),
              ),
              ListTile(
                trailing: Icon(
                  Icons.computer,
                  color: contractCheked.value ? Colors.red : Colors.grey,
                ),
                textColor: _contractColor,
                leading: Checkbox(
                  activeColor: Colors.white38,
                  shape: const CircleBorder(),
                  value: contractCheked.value,
                  onChanged: ((value) {
                    contractCheked.value = !contractCheked.value;

                    copier.copierMaintenance = contractCheked.value;

                    if (kDebugMode) {
                      print(value);
                      print('5 .  ${copier.copierMaintenance}');
                    }
                  }),
                ),
                title: contractCheked.value
                    ? Text(
                        _contractText,
                        style: const TextStyle(color: Colors.red),
                      )
                    : Text(_not + ' ' + _contractText),
              ),
              ListTile(
                trailing: Icon(
                  Icons.my_library_books,
                  color: propertyCheked.value ? Colors.red : Colors.grey,
                ),
                textColor: _propertyColor,
                leading: Checkbox(
                  activeColor: Colors.white38,
                  shape: const CircleBorder(),
                  value: propertyCheked.value,
                  onChanged: (value) {
                    propertyCheked.value = !propertyCheked.value;
                    copier.copierOwner = propertyCheked.value;

                    if (kDebugMode) {
                      print(value);
                      print('6 .  ${copier.copierOwner}');
                    }
                  },
                ),
                title: propertyCheked.value
                    ? Text(_propertyText)
                    : const Text('ملك المدرسة'),
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

                _savedata(copier);
                if (kDebugMode) {
                  print(copier.toString());
                }
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
