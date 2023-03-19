import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hook/models/printer.dart';
import 'package:hook/services/apiservice.dart';

import '../utils/style.dart';

class PrinterPages extends HookWidget {
  PrinterPages({super.key, required this.schoolID});
  String schoolID;
  List<Printer> printers = [];
  Printer? printer;
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    Future<void> _displayTextInputDialog(BuildContext context) async {
      return showDialog(
          context: context,
          builder: (context) {
            return AddNewPrinter(
              schoolID: schoolID,
            );
          });
    }

    Future<String> _fetchData() async {
      String result = ' Done';
      int count = await apiServices.getCountAll(schoolID, 'printerTbl');
      //print('fetch:  ${count.toString()}');
      if (count > 0) {
        printers = await apiServices.getfromprinter(schoolID, 'printerTbl');
        Future.delayed(Duration(seconds: 1));
        printer = printers[0];
        if (kDebugMode) {
          print(printer.toString());
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
                'بيانات  الطابعات ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              PopupMenuButton(
                  child: const Icon(Icons.add),
                  itemBuilder: (context) {
                    return [
                      const PopupMenuItem(
                        value: 'add',
                        child: Text('اضافة طابعة جديده '),
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
            ? Center(
                child: CircularProgressIndicator(),
              )
            : printers.length > 0
                ? ListView.builder(
                    itemCount: printers.length,
                    itemBuilder: (context, index) => PrinterCard(
                      printer: printers[index],
                    ),
                  )
                : Center(
                    child: Text('No Data Found'),
                  ),
      ),
    );
  }
}

class PrinterCard extends StatelessWidget {
  PrinterCard({super.key, required this.printer});
  Printer printer;
  ApiServices apiServices = ApiServices();
  Future<void> _deleteprinter(Printer printer) async {
    String result = await apiServices.deletePrinter(printer.ID!);
    if (kDebugMode) {
      print(result);
    }
  }

  Future<void> _displayTextInputDialog(BuildContext context) async {
    print(printer.ID.toString());
    return showDialog(
        context: context,
        builder: (context) {
          return EditDialog(
            printer: printer,
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
            print('');
          },
          leading: const Icon(
            Icons.print_rounded,
            color: Colors.amber,
          ),
          title: Text(
            '${printer.printerType}',
            style: textstyle,
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(right: 40.0),
            child: Text(
              '${printer.printerModel}',
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
                  ? _deleteprinter(printer)
                  : _displayTextInputDialog(context);
            },
          ),
        ),
      ),
    );
  }
}

class EditDialog extends StatelessWidget {
  EditDialog({super.key, required this.printer});
  Printer printer;

  ApiServices apiServices = ApiServices();
  void _savedata(Printer printer) async {
    var result =
        await apiServices.updatePrinterData(printer.toJson(), printer.ID!);
    if (kDebugMode) {
      print(result);
    }
  }

  TextEditingController _typeController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _dateController = TextEditingController();

  String? codeDialog;
  String? valueText;
  final List<String> _printerListName = [
    ' HP Lazerjet',
    'Cannon',
    'kyocera',
    'samsung',
    'Epson',
    'ather',
  ];
  @override
  Widget build(BuildContext context) {
    printer = printer;
    _typeController.text = printer.printerType;
    _modelController.text = printer.printerModel;
    _dateController.text = printer.printerDate;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 600,
        child: AlertDialog(
          title: const Text('بيانات الطابعة '),
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
                      items: _printerListName,
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

                        printer.printerType = _typeController.text;
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                textDirection: TextDirection.rtl,
                onChanged: (value) {
                  valueText = value;

                  printer.printerType = value;
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

                  printer.printerModel = value;
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
                onChanged: (value) {
                  valueText = value;

                  // widget.copier.copierCo = _companyController.text;

                  printer.printerDate = value;
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
                _savedata(printer);
                print(printer.ID);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AddNewPrinter extends StatelessWidget {
  AddNewPrinter({super.key, required this.schoolID});
  String schoolID;

  ApiServices apiServices = ApiServices();
  TextEditingController _typeController = TextEditingController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _companyController = TextEditingController();
  TextEditingController _counterController = TextEditingController();
  TextEditingController _mcounterController = TextEditingController();
  Printer printer =
      Printer(schoolId: '', printerType: '', printerModel: '', printerDate: '');
  void _savedata(Printer printer) async {
    printer.schoolId = schoolID;
    var result = await apiServices.addPrinterData(printer.toJson());
    print(result);
  }

  String? codeDialog;
  String? valueText;
  final List<String> _printerListName = [
    ' HP Lazerjet',
    'Cannon',
    'kyocera',
    'samsung',
    'Epson',
    'ather',
  ];
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: SizedBox(
        height: 600,
        child: AlertDialog(
          scrollable: true,
          title: const Center(
            child: Text('بيانات الطابعة '),
          ),
          content: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    flex: 1,
                    child: Text(
                      'نوع الطابعة ',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: DropdownSearch<String>(
                      items: _printerListName,
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

                        printer.printerType = _typeController.text;
                      },
                    ),
                  ),
                ],
              ),
              TextField(
                onChanged: (value) {
                  valueText = value;

                  printer.printerModel = value;
                },
                controller: _modelController,
                decoration: const InputDecoration(
                    label: Text(
                  "موديل الطابعة",
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
                  printer.printerDate = value;
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
                printer.schoolId = schoolID;
                _savedata(printer);

                print(printer.schoolId);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
