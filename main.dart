import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hook/models/school.dart';
import 'package:hook/services/api_services.dart';

void main() {
  runApp(
    GetMaterialApp(
      home: HomePage(),
    ),
  );
}

class HomePage extends HookWidget {
  HomePage({super.key});
  ApiServices apiServices = ApiServices();
  @override
  Widget build(BuildContext context) {
    Future<String> _fetchData() async {
      await apiServices.getmaindata('27112272', 'table');
      //Future.delayed(Duration(seconds: 1));
      return 'Hello';
    }

    final future = _fetchData();
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
