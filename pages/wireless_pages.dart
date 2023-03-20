import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hook/models/wireless_network.dart';
import '../services/apiservice.dart';

class WirelessMenu extends HookWidget {
  WirelessMenu({super.key, required this.schoolID});
  String schoolID;

  List<WirelessModel> wirelessModels = [];
  ApiServices apiServices = ApiServices();
  WirelessModel? wirelessModel;

  Future<void> _displayTextInputDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AddWirelessNetworkData(
            schoolId: schoolID,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    Future<String> _fetchData() async {
      String result = ' Done';
      int count =
          await apiServices.getCountAll(schoolID, 'wirelessNetworkData');
      //print('fetch:  ${count.toString()}');
      if (count > 0) {
        wirelessModels = await apiServices.getfromwirelessNetworkData(
            schoolID, 'wirelessNetworkData');
        Future.delayed(const Duration(seconds: 1));
        wirelessModel = wirelessModels[0];
        if (kDebugMode) {
          print(wirelessModel.toString());
        }
      } else {
        result = 'no data foud';
      }

      return result;
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
                'بيانات الشبكة اللاسلكية  ',
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
            : wirelessModels.isNotEmpty
                ? ListView.builder(
                    itemCount: wirelessModels.length,
                    itemBuilder: (context, index) => WirslessCard(
                      wirelessModels: wirelessModels[index],
                      index: index,
                    ),
                  )
                : const Center(
                    child: Text(' No  Data Found'),
                  ),
      ),
    );
  }
}

class WirslessCard extends StatelessWidget {
  WirslessCard({super.key, required this.wirelessModels, required this.index});
  WirelessModel wirelessModels;
  int index;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: index.isOdd ? Colors.blueAccent[100] : Colors.blueGrey[100],
        child: ListTile(
          leading: const Icon(Icons.favorite),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('النوع: ${wirelessModels.deviceType}'),
              Text('الموديل :${wirelessModels.deviceModel}')
            ],
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('العدد:  ${wirelessModels.deviceCounter.toString()}'),
              Text('المصدر:  ${wirelessModels.deviceSource}'),
            ],
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
              // value == 'delete'
              //     ? _deletelcd(lcd)
              //     : _displayTextInputDialog(context);
            },
          ),
        ),
      ),
    );
  }
}

class AddWirelessNetworkData extends StatelessWidget {
  AddWirelessNetworkData({super.key, required this.schoolId});
  String schoolId;

  WirelessModel wirelessModel = WirelessModel(
      ID: 0,
      schoolID: '',
      deviceType: '',
      deviceModel: '',
      deviceCounter: 0,
      deviceSource: '');

  ApiServices apiServices = ApiServices();
  void _savedata(WirelessModel wirelessModel) async {
    wirelessModel.schoolID = schoolId;
    if (kDebugMode) {
      print(wirelessModel.toString());
    }
    var result =
        await apiServices.addwirelessNetworkData(wirelessModel.toJson());
    if (kDebugMode) {
      print(result);
    }
  }

  String? codeDialog;
  String? valueText;
  final List<String> _typeList = [
    ' Switch',
    'Router   ',
    'Access Point   ',
  ];

  final List<String> _modelList = [
    ' Cisco',
    'NetGear',
    'TpLink',
    'Fortinet',
    'Dell',
    'Hp',
    '3Com',
    'Other'
  ];

  final List<String> _sourceList = ['وزارة التربية والتعليم', 'المجتمع المحلي'];

  final TextEditingController _typeController = TextEditingController();
  final TextEditingController _modelController = TextEditingController();
  final TextEditingController _counterController = TextEditingController();
  final TextEditingController _sourceController = TextEditingController();

  int Other = 0;
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
                      'نوع الجهاز ',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _typeList,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        scrollbarProps: ScrollbarProps(thickness: .2),
                        //comment this if you want that the items do not takes all available height
                        constraints: BoxConstraints.tightFor(),
                      ),
                      onChanged: (value) {
                        if (kDebugMode) {
                          print(value);
                        }

                        _typeController.text = value!;
                        wirelessModel.deviceType = _typeController.text;
                        //facilities.roomName = _nameController.text;
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'موديل الجهاز  ',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _modelList,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        scrollbarProps: ScrollbarProps(thickness: .2),
                        //comment this if you want that the items do not takes all available height
                        constraints: BoxConstraints.tightFor(),
                      ),
                      onChanged: (value) {
                        if (kDebugMode) {
                          print(value);
                        }
                        value == 'Other' ? Other = 1 : Other = 0;
                        _modelController.text = value!;
                        // controller.check.value = true;
                        wirelessModel.deviceModel = _modelController.text;
                        if (kDebugMode) {
                          print(Other);
                        }

                        //facilities.roomName = _nameController.text;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextField(
                      onChanged: (value) {
                        valueText = value;
                      },
                      controller: _counterController,
                      decoration: const InputDecoration(
                          label: Text(
                        "الموديل:  ",
                        style: TextStyle(color: Colors.blueAccent),
                      )),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    valueText = value;

                    //facilities.roomArea = int.parse(value);
                  },
                  controller: _counterController,
                  decoration: const InputDecoration(
                      label: Text(
                    "الموديل:  ",
                    style: TextStyle(color: Colors.blueAccent),
                  )),
                ),
              ),
              TextField(
                onChanged: (value) {
                  valueText = value;
                  wirelessModel.deviceCounter =
                      int.parse(_counterController.text);
                  //facilities.roomArea = int.parse(value);
                },
                controller: _counterController,
                decoration: const InputDecoration(
                    label: Text(
                  "العدد:  ",
                  style: TextStyle(color: Colors.blueAccent),
                )),
              ),
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'مصدر الجهاز  ',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _sourceList,
                      popupProps: const PopupProps.menu(
                        showSearchBox: true,
                        fit: FlexFit.loose,
                        scrollbarProps: ScrollbarProps(thickness: .2),
                        //comment this if you want that the items do not takes all available height
                        constraints: BoxConstraints.tightFor(),
                      ),
                      onChanged: (value) {
                        if (kDebugMode) {
                          print(value);
                        }

                        _sourceController.text = value!;
                        wirelessModel.deviceSource = _sourceController.text;

                        //facilities.roomName = _nameController.text;
                      },
                    ),
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
                //facilities.schoolID = schoolId;
                _savedata(wirelessModel);

                if (kDebugMode) {
                  print(wirelessModel.schoolID);
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
