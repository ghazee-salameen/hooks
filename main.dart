import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:hook/models/school.dart';
import 'package:hook/route/route.dart';
import 'package:hook/services/apiservice.dart';
import 'controller/school_controller.dart';

void main() {
  runApp(
    GetMaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    ),
  );
}
/*
class HomePage extends HookWidget {
  HomePage({super.key});
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    Future<String> _fetchData() async {
      await apiServices.getmaindata('27112272', 'table');
      Future.delayed(Duration(seconds: 1));
      if (kDebugMode) {
        print('object');
      }
      return 'Hello';
    }

    final future = useMemoized(_fetchData);
    final snapshot = useFuture(future);

    return Scaffold(
      appBar: AppBar(title: const Text('HOME')),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: snapshot.hasData
                  ? ListView.builder(
                      itemCount: apiServices.schools.length,
                      itemBuilder: (context, index) {
                        return SchoolCard(
                          school: apiServices.schools[index],
                        );
                      },
                    )
                  : Center(child: CircularProgressIndicator()),
            ),
            ElevatedButton(
              child: const Text('Go to page 2'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class SchoolCard extends HookWidget {
  SchoolCard({super.key, required this.school});
  SchoolModel school;

  @override
  Widget build(BuildContext context) {
    final pcCheck = useState(true);
    return ListTile(
      leading: CircleAvatar(child: Text(school.ID.toString())),
      title: Text(school.schoolName),
      subtitle: Text(school.internetSpeed),
      trailing: Checkbox(
        onChanged: (value) {
          pcCheck.value = value!;
        },
        value: pcCheck.value,
      ),
    );
  }
}
*/

class HomePage extends HookWidget {
  HomePage({super.key});
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    GetController controller = Get.put(GetController());

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue[600],
        title: const Text('Main Page'),
      ),
      body: Column(
        children: [
          const Center(
            child: Text('أدخل اسم المدرسة'),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Autocomplete<School>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    return SchoolsList.where((School continent) => continent
                            .sname
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase()))
                        .toList();
                  },
                  displayStringForOption: (School option) => option.sname,
                  optionsViewBuilder: (BuildContext context,
                      AutocompleteOnSelected<School> onSelected,
                      Iterable<School> options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        child: Container(
                          width: 300,
                          color: Colors.teal,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(10.0),
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final School option = options.elementAt(index);

                              return GestureDetector(
                                onTap: () {
                                  // controller.getmaindata(
                                  //     option.sid.toString(), '');
                                  onSelected(option);
                                  context.go('/school/${option.sid}');
                                },
                                child: ListTile(
                                  title: Text(option.sname,
                                      style:
                                          const TextStyle(color: Colors.white)),
                                  subtitle: Text(option.sid.toString(),
                                      style:
                                          const TextStyle(color: Colors.white)),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: SchoolsList.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        //apiServices.getmaindata
                        //controller.getmaindata('27112272', 'table');

                        context.go('/test2');
                      },
                      child: ListTile(
                        leading: const Icon(Icons.school),
                        trailing: const Text(
                          "GFG",
                          style: TextStyle(color: Colors.green, fontSize: 15),
                        ),
                        title: Text(SchoolsList[index].sname),
                        subtitle: Text('${SchoolsList[index].sid}'),
                      ),
                    );
                  })),
        ],
      ),
    );
  }
}
