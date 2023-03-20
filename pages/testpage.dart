import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hook/controller/custom_class.dart';
import 'package:hook/custom/alert.dart';

class TestPage2 extends HookWidget {
  TestPage2({super.key});

  void _print() {
    // controller.fetchData('27112272', "table");
    if (kDebugMode) {
      print('test');
    }
  }

  @override
  Widget build(BuildContext context) {
    final check = useState(true);
    // GetController controller = Get.find();
//final future = useMemoized(_fetchData);
    // final snapshot = useFuture(future);

    GetData getdata = GetData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Test2'),
      ),
      body: !check.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
                children: [
                  ListTile(
                    leading: Checkbox(
                        value: check.value,
                        onChanged: (Value) {
                          check.value = !check.value;
                          print(check.value);
                        }),
                    title: Text(check.value.toString()),
                  ),
                  const Text('schools.length.toString()'),
                  TextButton(
                    onPressed: () {
                      const AlertDialog(
                        title: Text('demo'),
                        content: Text('demo content'),
                      );
                    },
                    child: const Text('Schow Dialog'),
                  ),
                  CustomAlert(),
                  Text(getdata.lcd.toString()),
                ],
              ),
            ),
    );
  }
}
