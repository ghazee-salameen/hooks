import 'dart:convert';

import '../models/duplicater.dart';
import '../models/facilities.dart';
import '../models/lcd.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '../models/copier.dart';
import '../models/printer.dart';
import '../models/school.dart';
import '../models/user.dart';
import '../models/wireless_network.dart';

class ApiServices {
  List<SchoolModel> schools = [];
  SchoolModel? school;
  List<Copier> copiers = [];
  bool isWorking = false;

  String apipath = "http://localhost:81/apiphp/";

  Future<List<User>> getalldata() async {
    String endPoint = 'schools/readall.php';
    //String schoolID
    endPoint = apipath + endPoint;
    Response response = await get(Uri.parse(endPoint));
    //Response response = await get(Uri.parse(endPoint + '?schoolID=$schoolID'));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      if (kDebugMode) {
        print(response.body);
      }
      return result.map((e) => User.fromJson(e)).toList();
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<SchoolModel> getmaindata(String schoolID, String table) async {
    String mainEndPoint = 'schools/getschooldata.php?schoolID=$schoolID';
    mainEndPoint = apipath + mainEndPoint;
    //String schoolID
    //Response response = await get(Uri.parse(mainEndPoint));

    Response response = await get(Uri.parse(mainEndPoint));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      if (kDebugMode) {
        print(result[0]['schoolID']);
      }

      schools = result.map((e) => SchoolModel.fromJson(e)).toList();
      if (kDebugMode) {
        print(schools[0].schoolID);
      }
      school = schools[0];
      return school!;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // get data from any table you want

  Future<List<Copier>> getfrom(String schoolID, String table) async {
    String path = 'schools/readfrom.php?';
    String str = 'schoolID=$schoolID&table=$table';
    path = apipath + path + str;
    //Response response = await get(Uri.parse(mainEndPoint));

    Response response = await get(Uri.parse(path));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      //print('res : ${result[1]['ID']}');
      copiers = result.map((e) => Copier.fromJson(e)).toList();
      return copiers;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  // getData from Duplicater
  Future<List<Duplicater>> getfromdup(String schoolID, String table) async {
    String path = 'schools/readfrom.php?';
    String str = 'schoolID=$schoolID&table=$table';
    path = apipath + path + str;
    Response response = await get(Uri.parse(path));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => Duplicater.fromJson(e)).toList();
    } else {
      print('api');
      throw Exception(response.reasonPhrase);
    }
  }
// getData from Printer

  Future<List<Printer>> getfromprinter(String schoolID, String table) async {
    String path = 'schools/readfrom.php?';
    String str = 'schoolID=$schoolID&table=$table';
    path = apipath + path + str;
    Response response = await get(Uri.parse(path));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => Printer.fromJson(e)).toList();
    } else {
      print('api');
      throw Exception(response.reasonPhrase);
    }
  }

// delete Duplicater
  Future<String> deleteCopier(int ID) async {
    String deletestr = 'copier/delete.php?ID=$ID';
    deletestr = apipath + deletestr;
    Response response = await delete(Uri.parse(deletestr));
    if (response.statusCode == 200) {
      return 'done';
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<String> deleteDuplicater(int ID) async {
    String deletestr = 'duplicator/delete.php?ID=$ID';
    deletestr = apipath + deletestr;
    Response response = await delete(Uri.parse(deletestr));
    if (response.statusCode == 200) {
      return 'done';
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

// delete printer
  Future<String> deletePrinter(int ID) async {
    String deletestr = 'printer/delete.php?ID=$ID';
    deletestr = apipath + deletestr;
    Response response = await delete(Uri.parse(deletestr));
    if (response.statusCode == 200) {
      return 'done';
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  Future<dynamic> updateCopierData(Map body, int ID) async {
    String updateStr = "copier/update.php?ID=$ID";
    updateStr = apipath + updateStr;
    try {
      Response response =
          await put(Uri.parse(updateStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('done');
        }
      } else {
        if (kDebugMode) {
          print(' error not done');
        }
        throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      if (kDebugMode) {
        print('error e');
      }
    }
  }

  Future<dynamic> updateDuplicaterData(Map body, int ID) async {
    String updateStr = "duplicator/update.php?ID=$ID";
    updateStr = apipath + updateStr;
    try {
      Response response =
          await put(Uri.parse(updateStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('done');
        }
        return 'done updated';
      } else {
        if (kDebugMode) {
          print(' error not done');
        }
        throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      if (kDebugMode) {
        print('error e');
      }
    }
  }

  //update PrinterData
  Future<dynamic> updatePrinterData(Map body, int ID) async {
    String updateStr = "printer/update.php?ID=$ID";
    updateStr = apipath + updateStr;
    try {
      Response response =
          await put(Uri.parse(updateStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('done');
        }
        return 'done updated ${response.body}';
      } else {
        if (kDebugMode) {
          print(' error not done');
        }
        throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      if (kDebugMode) {
        print('error e');
      }
    }
  }

  Future<dynamic> updateSchoolData(Map body, String schoolID) async {
    String updateStr = "schools/update.php?schoolID=$schoolID";
    updateStr = apipath + updateStr;
    try {
      Response response =
          await put(Uri.parse(updateStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('done');
        }
        return 'updated successfully';
      } else {
        if (kDebugMode) {
          print(' error not done  ${response.statusCode}');
        }
        throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      if (kDebugMode) {
        print('error e');
      }
    }
  }

//addCopierData
  Future<dynamic> addCopierData(Map body) async {
    String insertStr = "copier/create.php";
    insertStr = apipath + insertStr;
    try {
      // Map bo = {
      //   "schoolID": "27112272",
      //   "copierType": "new1",
      //   "copierCo": "5454",
      //   "copierModel": "4545",
      //   "copierMaintenance": "1",
      //   "copierOwner": "1",
      //   "counter": "300"
      // };

      Response response =
          await post(Uri.parse(insertStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('done ');
      } else {
        print('post error not done ${response.statusCode}');
        // throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      print('error e');
    }
  }

//addDuplicaterData
  Future<dynamic> addDuplicaterData(Map body) async {
    String insertStr = "duplicator/create.php";
    insertStr = apipath + insertStr;
    try {
      Response response =
          await post(Uri.parse(insertStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('done ');
        return response.body;
      } else {
        print('post error not done ${response.body}');
        // throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      print('error e');
    }
  }

  Future<dynamic> addPrinterData(Map body) async {
    String insertStr = "printer/create.php";
    insertStr = apipath + insertStr;
    try {
      // Map bo = {
      //   "schoolID": "27112272",
      //   "copierType": "new1",
      //   "copierCo": "5454",
      //   "copierModel": "4545",
      //   "copierMaintenance": "1",
      //   "copierOwner": "1",
      //   "counter": "300"
      // };

      Response response =
          await post(Uri.parse(insertStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('done ');
      } else {
        print('post error not done ${response.body}');
        // throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      print('error e');
    }
  }

///// function for Lcds
  ///
  Future<List<Lcd>> getfromlcd(String schoolID, String table) async {
    String path = 'schools/readfrom.php?';
    String str = 'schoolID=$schoolID&table=$table';
    path = apipath + path + str;
    Response response = await get(Uri.parse(path));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => Lcd.fromJson(e)).toList();
    } else {
      print('api');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<dynamic> addLcdData(Map body) async {
    String insertStr = "lcd/create.php";
    insertStr = apipath + insertStr;
    try {
      Response response =
          await post(Uri.parse(insertStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('done ');
      } else {
        print('post error not done ${response.body}');
        // throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      print('error e');
    }
  }

  Future<dynamic> updateLcdData(Map body, int ID) async {
    String updateStr = "lcd/update.php?ID=$ID";
    updateStr = apipath + updateStr;
    try {
      Response response =
          await put(Uri.parse(updateStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('done');
        }
        return 'done updated ${response.body}';
      } else {
        if (kDebugMode) {
          print(' error not done');
        }
        throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      if (kDebugMode) {
        print('error e');
      }
    }
  }

  Future<String> deleteLcd(int ID) async {
    String deletestr = 'lcd/delete.php?ID=$ID';
    deletestr = apipath + deletestr;
    Response response = await delete(Uri.parse(deletestr));
    if (response.statusCode == 200) {
      return 'done';
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  ///// function for facilities
  ///
  Future<List<Facilities>> getfromfacilities(
      String schoolID, String table) async {
    String path = 'schools/readfrom.php?';
    String str = 'schoolID=$schoolID&table=$table';
    path = apipath + path + str;
    Response response = await get(Uri.parse(path));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => Facilities.fromJson(e)).toList();
    } else {
      print('api');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<dynamic> addfacilitiesData(Map body) async {
    String insertStr = "facilities/create.php";
    insertStr = apipath + insertStr;
    try {
      Response response =
          await post(Uri.parse(insertStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('done ');
      } else {
        print('post error not done ${response.body}');
        // throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      print('error e');
    }
  }

  Future<dynamic> updatefacilitiesData(Map body, int ID) async {
    String updateStr = "facilities/update.php?ID=$ID";
    updateStr = apipath + updateStr;
    try {
      Response response =
          await put(Uri.parse(updateStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('done');
        }
        return 'done updated ${response.body}';
      } else {
        if (kDebugMode) {
          print(' error not done');
        }
        throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      if (kDebugMode) {
        print('error e');
      }
    }
  }

  Future<String> deletefacilities(int ID) async {
    String deletestr = 'facilities/delete.php?ID=$ID';
    deletestr = apipath + deletestr;
    Response response = await delete(Uri.parse(deletestr));
    if (response.statusCode == 200) {
      return 'done';
    } else {
      throw Exception(response.reasonPhrase);
    }
  }

  ///// function for wirelessNetworkData
  ///
  Future<List<WirelessModel>> getfromwirelessNetworkData(
      String schoolID, String table) async {
    String path = 'schools/readfrom.php?';
    String str = 'schoolID=$schoolID&table=$table';
    path = apipath + path + str;
    Response response = await get(Uri.parse(path));
    if (response.statusCode == 200) {
      final List result = jsonDecode(response.body)['data'];
      return result.map((e) => WirelessModel.fromJson(e)).toList();
    } else {
      print('api');
      throw Exception(response.reasonPhrase);
    }
  }

  Future<dynamic> addwirelessNetworkData(Map body) async {
    String insertStr = "wireless/create.php";
    insertStr = apipath + insertStr;
    try {
      Response response =
          await post(Uri.parse(insertStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        print('done ');
      } else {
        print('post error not done ${response.body}');
        // throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      print('error e');
    }
  }

  Future<dynamic> updatewirelessNetworkData(Map body, int ID) async {
    String updateStr = "wireless/update.php?ID=$ID";
    updateStr = apipath + updateStr;
    try {
      Response response =
          await put(Uri.parse(updateStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('done');
        }
        return 'done updated ${response.body}';
      } else {
        if (kDebugMode) {
          print(' error not done');
        }
        throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      if (kDebugMode) {
        print('error e');
      }
    }
  }

  Future<String> deletewirelessNetworkData(int ID) async {
    String deletestr = 'wireless/delete.php?ID=$ID';
    deletestr = apipath + deletestr;
    Response response = await delete(Uri.parse(deletestr));
    if (response.statusCode == 200) {
      return 'done';
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
