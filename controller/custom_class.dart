import 'package:flutter/foundation.dart';
import 'package:hook/models/lcd.dart';
import 'package:hook/services/apiservice.dart';

class GetData {
  List<Lcd> lcds = [];
  Lcd? lcd;
  ApiServices apiServices = ApiServices();
  Future<String> fetchData() async {
    String result = ' Done';
    int count = await apiServices.getCountAll('2711227', 'lcdTbl');
    //print('fetch:  ${count.toString()}');
    if (count > 0) {
      lcds = await apiServices.getfromlcd('2711227', 'lcdTbl');
      Future.delayed(const Duration(seconds: 1));
      lcd = lcds[0];
      if (kDebugMode) {
        print(lcd.toString());
      }
    } else {
      result = 'no data foud';
    }

    return result;
  }
}
