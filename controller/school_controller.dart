import 'package:get/get.dart';

import '../models/duplicater.dart';

class GetController extends GetxController {
  // school variables
  var isWorking = true.obs;
  var schoolsList = [].obs;

  RxBool check = false.obs;
  // Duplicater variables

  List<Duplicater> duplicaters = [];

  change(int variable, int type) {
    check.value = !check.value;
  }

  // void getfromdup(String schoolID) async {
  //   try {
  //     isWorking.value = true;
  //     duplicaters = await apiServices.getfromdup(schoolID, 'duplicaterTbl');
  //     if (kDebugMode) {
  //       print(duplicaters[0].duplicaterType);
  //     }
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print('$error this');
  //     }
  //   } finally {
  //     isWorking.value = false;
  //     if (kDebugMode) {
  //       print('finally');
  //     }
  //   }
  // }
}
