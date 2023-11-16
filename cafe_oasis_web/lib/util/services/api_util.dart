import 'dart:convert';

import 'package:cafe_oasis_web/screens/user_screens/login_screen.dart';
import 'package:http/http.dart' as http;

class ApiUtil {
  static const String baseUrl = "http://cafeoasis.xyz";
  static const int timeoutSec = 10;

//http://cafeoasis.xyz/cafe?search_target=카페
  static Future<dynamic> cafeSearch(String searchStr) {
    final url = Uri.parse('$baseUrl/cafe?search_target=$searchStr');
    dynamic returnValue;
    return http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
      },
    ).then((response) {
      if (response.statusCode == 200) {
        // print(response.body);
        String decodedData = utf8.decode(response.bodyBytes);
        // print(decodedData);
        var decoded = json.decode(decodedData);
        returnValue = decoded['cafe_list'];
        return returnValue;
      } else {
        return {};
      }
    }).timeout(
      const Duration(seconds: timeoutSec),
      onTimeout: () => {}, // 3초 후에 실행될 대체값입니다.
    );
  }

  static Future<bool> cafeUpdate(
      {required String cafeName,
      required String phone,
      required String desc,
      required String openHour}) {
    final url = Uri.parse('$baseUrl/cafe');
    return http
        .put(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'cafe_name': cafeName,
        'cafe_value_list': [phone, desc, openHour],
      }),
    )
        .then((response) {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    }).timeout(
      const Duration(seconds: timeoutSec),
      onTimeout: () => false, // 3초 후에 실행될 대체값입니다.
    );
  }
}
