import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hook/models/school.dart';

import '../controller/school_controller.dart';
import '../models/choice.dart';
import '../services/apiservice.dart';
import '../utils/style.dart';

class MainPage extends HookWidget {
  MainPage({super.key, required this.schoolID});
  String schoolID;

  ApiServices apiServices = ApiServices();
  void _saveData(Map body, String schoolID) async {
    var test = await apiServices.updateSchoolData(body, schoolID);
    print(test);
  }

  SchoolModel school = SchoolModel(
      schoolID: '0',
      schoolName: 'schoolName',
      computerLab: 0,
      tecLab: 0,
      sinceLab: 0,
      library: 0,
      wirelessNetwork: 0,
      attendanceClock: 0,
      lanNetWork: 0,
      internet: 0,
      internetSpeed: '');

  List<String> internetspeed = [
    '4 Mbps',
    '8 Mbps',
    '16 Mbps',
    '30 Mbps',
    'fiper'
  ];

  String dropdownValue = '4 Mbps';
  @override
  Widget build(BuildContext context) {
    // List<SchoolModel> schools
    final pccheckvalue = useState(false);
    final teccheckvalue = useState(false);
    final sincheckvalue = useState(false);
    final libcheckvalue = useState(false);
    final wircheckvalue = useState(false);
    final attlibcheckvalue = useState(false);
    final lancheckvalue = useState(false);
    final intcheckvalue = useState(false);
    final intspeed = useState("4 Mbps");

    //GetController controller = Get.put(GetController());
    Future<String> _fetchData() async {
      school = await apiServices.getmaindata('27112272', 'table');
      Future.delayed(Duration(seconds: 1));
      if (kDebugMode) {
        print(school.toString());
      }
      return 'Hello';
    }

    final future = useMemoized(_fetchData);
    final snapshot = useFuture(future);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'البيانات العامة لمدرسة ',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        centerTitle: true,
      ),
      body: !snapshot.hasData
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Text(school.schoolName,
                      style: Theme.of(context).textTheme.labelLarge),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 12, left: 12, bottom: 8),
                        child: Card(
                          color: Colors.blue[800],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(
                                  value: pccheckvalue.value ||
                                          school.computerLab == 1
                                      ? true
                                      : false,
                                  onChanged: (Value) {
                                    pccheckvalue.value = !pccheckvalue.value;
                                    pccheckvalue.value
                                        ? school.computerLab = 1
                                        : school.computerLab = 0;
                                    if (kDebugMode) {
                                      print(pccheckvalue.value);
                                      print(school.computerLab);
                                    }
                                  }),
                              Text(
                                school.computerLab == 1 ? 'يوجد ' : 'لا يوجد',
                                style: text,
                              ),
                              Text(
                                'مختبر حاسوب',
                                style: text,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 12, left: 12, bottom: 8),
                        child: Card(
                          color: const Color.fromARGB(255, 24, 118, 226),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(
                                  value:
                                      teccheckvalue.value || school.tecLab == 1
                                          ? true
                                          : false,
                                  onChanged: (Value) {
                                    teccheckvalue.value = !teccheckvalue.value;
                                    teccheckvalue.value
                                        ? school.tecLab = 1
                                        : school.tecLab = 0;
                                  }),
                              Text(
                                school.tecLab == 1 ? 'يوجد ' : 'لا يوجد',
                                style: textstyle,
                              ),
                              Text(
                                'مختبر تكنولوجيا',
                                style: textstyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 12, left: 12, bottom: 8),
                        child: Card(
                          color: Colors.blue[800],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(
                                  value: sincheckvalue.value ||
                                          school.sinceLab == 1
                                      ? true
                                      : false,
                                  onChanged: (Value) {
                                    sincheckvalue.value = !sincheckvalue.value;
                                    sincheckvalue.value
                                        ? school.sinceLab = 1
                                        : school.sinceLab = 0;
                                  }),
                              Text(
                                school.sinceLab == 1 ? 'يوجد ' : 'لا يوجد',
                                style: text,
                              ),
                              Text(
                                'مختبر علوم',
                                style: text,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 12, left: 12, bottom: 8),
                        child: Card(
                          color: const Color.fromARGB(255, 24, 118, 226),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(
                                  value:
                                      libcheckvalue.value || school.library == 1
                                          ? true
                                          : false,
                                  onChanged: (Value) {
                                    libcheckvalue.value = !libcheckvalue.value;
                                    libcheckvalue.value
                                        ? school.library = 1
                                        : school.library = 0;
                                  }),
                              Text(
                                school.library == 1 ? 'يوجد ' : 'لا يوجد',
                                style: textstyle,
                              ),
                              Text(
                                'مــكــتــبــة',
                                style: textstyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 12, left: 12, bottom: 8),
                        child: Card(
                          color: Colors.blue[800],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(
                                  value: wircheckvalue.value ||
                                          school.wirelessNetwork == 1
                                      ? true
                                      : false,
                                  onChanged: (Value) {
                                    wircheckvalue.value = !wircheckvalue.value;
                                    wircheckvalue.value
                                        ? apiServices
                                            .schools[0].wirelessNetwork = 1
                                        : apiServices
                                            .schools[0].wirelessNetwork = 0;
                                  }),
                              Text(
                                school.wirelessNetwork == 1
                                    ? 'يوجد '
                                    : 'لا يوجد',
                                style: text,
                              ),
                              Text(
                                'شبكة لا سلكية ',
                                style: text,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 12, left: 12, bottom: 8),
                        child: Card(
                          color: const Color.fromARGB(255, 24, 118, 226),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(
                                  value: attlibcheckvalue.value ||
                                          school.attendanceClock == 1
                                      ? true
                                      : false,
                                  onChanged: (Value) {
                                    attlibcheckvalue.value =
                                        !attlibcheckvalue.value;
                                    attlibcheckvalue.value
                                        ? school.attendanceClock = 1
                                        : school.attendanceClock = 0;
                                  }),
                              Text(
                                school.attendanceClock == 1
                                    ? 'يوجد '
                                    : 'لا يوجد',
                                style: textstyle,
                              ),
                              Text(
                                'ساعة دوام',
                                style: textstyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 12, left: 12, bottom: 8),
                        child: Card(
                          color: Colors.blue[800],
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(
                                  value: lancheckvalue.value ||
                                          school.lanNetWork == 1
                                      ? true
                                      : false,
                                  onChanged: (Value) {
                                    lancheckvalue.value = !lancheckvalue.value;
                                    lancheckvalue.value
                                        ? school.lanNetWork = 1
                                        : school.lanNetWork = 0;
                                  }),
                              Text(
                                school.lanNetWork == 1 && lancheckvalue.value
                                    ? 'يوجد '
                                    : 'لا يوجد',
                                style: text,
                              ),
                              Text(
                                'شبكة سلكية ',
                                style: text,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 12, left: 12, bottom: 8),
                        child: Card(
                          color: const Color.fromARGB(255, 24, 118, 226),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Checkbox(
                                  value: intcheckvalue.value ||
                                          school.internet == 1
                                      ? true
                                      : false,
                                  onChanged: (Value) {
                                    intcheckvalue.value = !intcheckvalue.value;
                                    intcheckvalue.value
                                        ? school.internet = 1
                                        : school.internet = 0;
                                  }),
                              Text(
                                school.internet == 1 ? 'يوجد ' : 'لا يوجد',
                                style: textstyle,
                              ),
                              Text(
                                'انـــتــرنــت ',
                                style: textstyle,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 12, left: 12, bottom: 8),
                        child: Visibility(
                          visible: school.internet == 1 ? true : false,
                          child: Card(
                            color: const Color.fromARGB(255, 24, 118, 226),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                DropdownButton(
                                    value: intspeed.value,
                                    items: internetspeed
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                          value: value, child: Text(value));
                                    }).toList(),
                                    onChanged: (String? value) {
                                      intspeed.value = value.toString();

                                      dropdownValue = value!;
                                      school.internetSpeed = value;
                                      print(
                                          '$dropdownValue, ${intspeed.value}');
                                    }),
                                Text(
                                  //controller.intspeed.value,
                                  school.internetSpeed,
                                  style: textstyle,
                                ),
                                Text(
                                  'سرعة الانترنت ',
                                  style: textstyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, right: 12, left: 12, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            TextButton.icon(
                              label: Text(
                                'التالي',
                                style: text,
                              ),
                              onPressed: () {
                                if (kDebugMode) {
                                 // print(apiServices.isWorking.value);
                                }

                                context.go('/menu/${school.schoolID}');
                              },
                              icon: const Icon(Icons.arrow_back),
                            ),
                            TextButton.icon(
                              label: Text('حــفــظ', style: text),
                              onPressed: () {
                                // Map<String, dynamic> school = {
                                //   "computerLab": pccheckvalue.value ? "1" : "0",
                                //   "tecLab": teccheckvalue.value ? "1" : "0",
                                //   "sinceLab": sincheckvalue.value ? "1" : "0",
                                //   "library": libcheckvalue.value ? "1" : "0",
                                //   "wirelessNetwork":
                                //       wircheckvalue.value ? "1" : "0",
                                //   "attendanceClock":
                                //       attlibcheckvalue.value ? "1" : "0",
                                //   "lanNetwork": lancheckvalue.value ? "1" : "0",
                                //   "internet": intcheckvalue.value ? "1" : "0",
                                //   "internetSpeed": intspeed.value
                                // };

                                print(school.toString());
                                _saveData(school.toMap(), '27112272');

                                if (kDebugMode) {
                                  print('save done');
                                }
                              },
                              icon: const Icon(Icons.save_rounded),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class PageMenu extends StatelessWidget {
  PageMenu({
    super.key,
    required this.schoolID,
  });
  String schoolID;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('القائمة الرئيسية'),
        centerTitle: true,
      ),
      body: Center(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
            ),
            itemCount: choices.length,
            itemBuilder: (BuildContext context, int index) {
              return SelectCard(
                schoolID: schoolID,
                choice: choices[index],
              );
            }),
      ),
    );
  }
}

class SelectCard extends GetView<GetController> {
  SelectCard({super.key, required this.choice, required this.schoolID});

  Choice choice;
  String schoolID;
  @override
  Widget build(BuildContext context) {
    var hight = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      child: SizedBox(
        width: hight * .2,
        height: hight * .2,
        child: Card(
            color: Colors.blue[800],
            child: Center(
              child: InkWell(
                onTap: () {
                  if (kDebugMode) {
                    print(choice.deviceid);
                  }
                  switch (choice.deviceid) {
                    case 1:
                      context.go('/copier/${controller.schools[0].schoolID}');
                      break;
                    case 2:
                      context
                          .go('/duplicater/${controller.schools[0].schoolID}');
                      if (kDebugMode) {
                        print('test2');
                      }
                      break;
                    case 3:
                      context.go('/lcd/${controller.schools[0].schoolID}');
                      break;
                    case 4:
                      context.go('/printer/${controller.schools[0].schoolID}');
                      break;
                    case 5:
                      context.go('/wireless/${controller.schools[0].schoolID}');
                      break;
                    case 6:
                      context
                          .go('/facilities/${controller.schools[0].schoolID}');
                      break;
                    default:
                      if (kDebugMode) {
                        print('test');
                      }
                  }
                },
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: Icon(choice.icon,
                              size: 50.0, color: textstyle.color)),
                      Text(choice.title, style: textstyle),
                    ]),
              ),
            )),
      ),
    );
  }
}