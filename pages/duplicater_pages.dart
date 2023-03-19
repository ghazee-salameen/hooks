import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hook/models/duplicater.dart';
import '../services/apiservice.dart';
import '../utils/style.dart';

class DuplicaterMenu extends HookWidget {
  DuplicaterMenu({super.key, required this.schoolID});
  String schoolID;
  List<Duplicater> duplicaters = [];
  ApiServices apiServices = ApiServices();
  Duplicater? duplicater;

  @override
  Widget build(BuildContext context) {
    Future<String> _fetchData() async {
      String result = ' Done';
      int count = await apiServices.getCountAll(schoolID, 'duplicaterTbl');
      //print('fetch:  ${count.toString()}');
      if (count > 0) {
        duplicaters = await apiServices.getfromdup(schoolID, 'duplicaterTbl');
        Future.delayed(Duration(seconds: 1));
        duplicater = duplicaters[0];
        if (kDebugMode) {
          print(duplicater.toString());
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
            return AddNewDuplicater(
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
                'بيانات ماكنات السحب',
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
            ],
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 200, 231, 245),
        ),
        body: !snapshot.hasData
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : duplicaters.length > 0
                ? ListView.builder(
                    itemCount: duplicaters.length,
                    itemBuilder: (context, index) => DuplicaterCard(
                      duplicater: duplicaters[index],
                    ),
                  )
                : Center(child: Text('No Data Found')),
      ),
    );
  }
}

class DuplicaterCard extends HookWidget {
  DuplicaterCard({super.key, required this.duplicater});
  Duplicater duplicater;
  ApiServices apiServices = ApiServices();

  Future<void> _deleteduplicater(var duplicater) async {
    String result = await apiServices.deleteDuplicater(duplicater.ID);
    if (kDebugMode) {
      print(result);
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    if (kDebugMode) {
      print(duplicater.ID);
    }
    return showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            duplicater: duplicater,
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
            print(duplicater.toString());
          },
          leading: const Icon(
            Icons.scanner,
            color: Colors.amber,
          ),
          title: Text(
            '${duplicater.duplicaterType}',
            style: textstyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text(
              '${duplicater.duplicaterModel}',
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
                  ? _deleteduplicater(duplicater)
                  : _displayTextInputDialog(context);
            },
          ),
        ),
      ),
    );
  }
}

class CustomDialog extends HookWidget {
  CustomDialog({super.key, required this.duplicater});
  Duplicater duplicater;
  TextEditingController _typeController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _counterController = TextEditingController();
  TextEditingController _mcounterController = TextEditingController();

  String? codeDialog;
  String? valueText;
  ApiServices apiServices = ApiServices();
  void _savedata(Duplicater duplicater) async {
    var result = await apiServices.updateDuplicaterData(
        duplicater.toMap(), duplicater.ID!);
    if (kDebugMode) {
      print(result);
    }
  }

  bool done = false;

  List<String> _duplicaterListName = ['Riso', 'Richo', 'ather'];
  @override
  Widget build(BuildContext context) {
    _typeController.text = duplicater.duplicaterType!;
    _modelController.text = duplicater.duplicaterModel!;
    _companyController.text = duplicater.duplicaterDate.toString();
    _counterController.text = duplicater.cCounter.toString();
    _mcounterController.text = duplicater.mCounter.toString();

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 600,
        child: AlertDialog(
          title: const Text('بيانات ماكنة السحب'),
          content: Column(
            children: [
              TextField(
                onChanged: (value) {
                  valueText = value;

                  duplicater.duplicaterType = value;
                },
                controller: _typeController,
                decoration: const InputDecoration(
                  label: Text('نوع ماكنة السحب'),
                ),
              ),
              TextField(
                onSubmitted: (value) {
                  valueText = value;

                  duplicater.duplicaterModel = value;
                },
                controller: _modelController,
                decoration: const InputDecoration(label: Text("موديل الماكنة")),
              ),
              TextField(
                controller: _companyController,
                decoration:
                    const InputDecoration(label: Text('  تاريخ الادخال')),
                onSubmitted: (value) {
                  valueText = value;
                  duplicater.duplicaterDate = value;
                  // widget.copier.copierCo = _companyController.text;
                },
              ),
              TextField(
                controller: _counterController,
                decoration: const InputDecoration(
                  label: Text('عداد الماكنة'),
                ),
                onSubmitted: (value) {
                  duplicater.cCounter = value.isNotEmpty ? int.parse(value) : 0;
                },
                keyboardType: TextInputType.number,
              ),
              TextField(
                controller: _mcounterController,
                decoration: const InputDecoration(
                  label: Text('عداد الماستر'),
                ),
                onSubmitted: (value) {
                  duplicater.mCounter = value.isNotEmpty ? int.parse(value) : 0;
                },
                keyboardType: TextInputType.number,
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
                if (kDebugMode) {
                  print(duplicater.schoolId);
                }
                _savedata(duplicater);

                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewDuplicater extends HookWidget {
  AddNewDuplicater({super.key, required this.schoolID});
  String schoolID;
  TextEditingController _typeController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _counterController = TextEditingController();
  TextEditingController _mcounterController = TextEditingController();

  String? codeDialog;
  String? valueText;
  bool _contractCheked = false;
  Color _contractColor = Colors.grey;
  String _contractText = 'يوجد عقد صيانة';
  String _not = 'لا';
  bool _propertyCheked = false;
  Color _propertyColor = Colors.grey;
  String _propertyText = 'مستأجرة';
  String _notp = '  ليست ';

  Duplicater duplicater = Duplicater(
      ID: 0,
      schoolId: '',
      duplicaterType: '',
      duplicaterModel: '',
      duplicaterDate: '',
      mCounter: 0,
      cCounter: 0);
  // save to database
  ApiServices apiServices = ApiServices();
  void _savedata(Duplicater duplicater) async {
    duplicater.schoolId = schoolID;
    var result = await apiServices.addDuplicaterData(duplicater.toMap());
    print(result);
  }

  List<String> _duplicaterListName = ['Riso', 'Richo', 'ather'];
  @override
  Widget build(BuildContext context) {
    final text = useTextEditingController.fromValue(TextEditingValue.empty);
    TextStyle? labelTextStyle = Theme.of(context).textTheme.labelLarge;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 600,
        child: AlertDialog(
          title: Text('بيانات ماكنة السحب'),
          content: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Text(
                      'نوع ماكنة السحب ',
                      style: labelTextStyle,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _duplicaterListName,
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

                        duplicater.duplicaterType = value;
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                onChanged: (value) {
                  valueText = value;

                  duplicater.duplicaterModel = value;
                },
                controller: _modelController,
                decoration: InputDecoration(label: Text("موديل الماكنة")),
              ),
              TextField(
                controller: _companyController,
                decoration: InputDecoration(label: Text('  تاريخ الادخال')),
                onChanged: (value) {
                  // widget.copier.copierCo = _companyController.text;

                  duplicater.duplicaterDate = value;
                },
              ),
              TextField(
                onChanged: (value) {
                  valueText = value;

                  duplicater.cCounter = value.isNotEmpty ? int.parse(value) : 0;
                },
                controller: _counterController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('عداد الماكنة'),
                ),
              ),
              TextField(
                onChanged: (value) {
                  valueText = value;

                  duplicater.mCounter = value.isNotEmpty ? int.parse(value) : 0;
                },
                controller: _mcounterController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  label: Text('عداد الماستر'),
                ),
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
                duplicater.schoolId = schoolID;
                print(
                    'type: ${duplicater.duplicaterType} , model: ${duplicater.duplicaterModel} ');
                _savedata(duplicater);

                print(duplicater.schoolId);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
