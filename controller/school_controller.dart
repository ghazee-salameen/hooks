import 'dart:convert';
import '../models/facilities.dart';
import '../models/school.dart';
import '../models/wireless_network.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/copier.dart';
import '../models/duplicater.dart';
import '../models/lcd.dart';
import '../models/printer.dart';
import '../services/apiservice.dart';

class GetController extends GetxController {
  ApiServices apiServices = ApiServices();
  // school variables
  var isWorking = true.obs;
  var schoolsList = [].obs;
  List<SchoolModel> schools = [];
  RxBool pccheckvalue = false.obs;
  RxBool teccheckvalue = false.obs;
  RxBool sincheckvalue = false.obs;
  RxBool libcheckvalue = false.obs;
  RxBool wircheckvalue = false.obs;
  RxBool attlibcheckvalue = false.obs;
  RxBool lancheckvalue = false.obs;
  RxBool intcheckvalue = false.obs;
  RxString intspeed = "4 Mbps".obs;
  // Copier variables
  List<Copier> copiers = [];
  RxBool maintenance = false.obs;
  RxBool contract = false.obs;

  RxBool check = false.obs;
  // Duplicater variables

  List<Duplicater> duplicaters = [];

  List<Printer> printers = [];

  List<Lcd> lcds = [];

  List<Facilities> facilities = [];

  List<WirelessModel> wirelessModels = [];

  change(int variable, int type) {
    check.value = !check.value;
  }

  String apipath = "http://localhost:81/apiphp/";
  void getmaindata(String schoolID, String table) async {
    isWorking.value = true;
    try {
      String mainEndPoint = apipath + 'schools/getschooldata.php?schoolID=';
      //String schoolID
      //Response response = await get(Uri.parse(mainEndPoint));
      var response = await http.get(Uri.parse(mainEndPoint + '$schoolID'));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)['data'];
        if (kDebugMode) {
          print(result[0]);
        }

        schools = result.map((e) => SchoolModel.fromJson(e)).toList();
        if (kDebugMode) {
          print(schools[0].schoolID);
        }
      } else {
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      if (kDebugMode) {
        print('error');
      }
    } finally {
      isWorking.value = false;
      if (kDebugMode) {
        print('finally');
      }
    }
  }

  void getfrom(String schoolID) async {
    try {
      isWorking.value = true;
      copiers = await apiServices.getfrom(schoolID, 'copierTbl');
      print(copiers[0].copierModel);
    } catch (error) {
      if (kDebugMode) {
        print('$error');
      }
    } finally {
      isWorking.value = false;
      if (kDebugMode) {
        print('finally');
      }
    }
  }

  void getfromdup(String schoolID) async {
    try {
      isWorking.value = true;
      duplicaters = await apiServices.getfromdup(schoolID, 'duplicaterTbl');
      if (kDebugMode) {
        print(duplicaters[0].duplicaterType);
      }
    } catch (error) {
      if (kDebugMode) {
        print('$error this');
      }
    } finally {
      isWorking.value = false;
      if (kDebugMode) {
        print('finally');
      }
    }
  }

  void getfromprinter(String schoolID) async {
    try {
      isWorking.value = true;
      printers = await apiServices.getfromprinter(schoolID, 'printerTbl');
      if (kDebugMode) {
        print(printers[0].printerType);
      }
    } catch (error) {
      if (kDebugMode) {
        print('$error this');
      }
    } finally {
      isWorking.value = false;
      if (kDebugMode) {
        print('finally');
      }
    }
  }

  void getfromlcd(String schoolID) async {
    try {
      isWorking.value = true;
      lcds = await apiServices.getfromlcd(schoolID, 'lcdTbl');
      if (kDebugMode) {
        print(lcds[0].lcdType);
      }
    } catch (error) {
      if (kDebugMode) {
        print('$error this');
      }
    } finally {
      isWorking.value = false;
      if (kDebugMode) {
        print('finally');
      }
    }
  }

  void getfromfacilities(String schoolID) async {
    try {
      isWorking.value = true;
      facilities =
          await apiServices.getfromfacilities(schoolID, 'facilitiesTbl');
      if (kDebugMode) {
        print(facilities[0].roomName);
      }
    } catch (error) {
      if (kDebugMode) {
        print('$error this');
      }
    } finally {
      isWorking.value = false;
      if (kDebugMode) {
        print('finally');
      }
    }
  }

  void getfromwirelessnetworkdata(String schoolID) async {
    try {
      isWorking.value = true;
      wirelessModels = await apiServices.getfromwirelessNetworkData(
          schoolID, 'wirelessNetworkData');
      if (kDebugMode) {
        print(wirelessModels[0].deviceType);
      }
    } catch (error) {
      if (kDebugMode) {
        print('$error this');
      }
    } finally {
      isWorking.value = false;
      if (kDebugMode) {
        print('finally');
      }
    }
  }
}
