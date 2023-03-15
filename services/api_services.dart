import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

import '../models/school.dart';

class ApiServices {
  String apipath = "http://localhost:81/apiphp/";

  List<SchoolModel> schools = [];
  Future<String> addDuplicaterData(Map body) async {
    String insertStr = "duplicator/create.php";
    insertStr = apipath + insertStr;
    try {
      Response response =
          await post(Uri.parse(insertStr), body: jsonEncode(body));
      if (response.statusCode == 200) {
        print(response.body);
        return 'done ';
      } else {
        if (kDebugMode) {
          print('post error not done ${response.body}');
        }
        // throw jsonDecode(response.body)['meta']['message'] ?? " unknoun Error ";
      }
    } catch (e) {
      if (kDebugMode) {
        print('error e');
      }
    } finally {
      return 'done ';
    }
  }

  Future<List<SchoolModel>> getmaindata(String schoolID, String table) async {
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
      return schools;
    } else {
      throw Exception(response.reasonPhrase);
    }
  }
}
