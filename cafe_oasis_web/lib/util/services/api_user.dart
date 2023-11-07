import 'dart:convert';

import 'package:cafe_oasis_web/model/user_model.dart';
import 'package:cafe_oasis_web/screens/user_screens/login_screen.dart';
import 'package:http/http.dart' as http;

class ApiUser {
  static const String baseUrl = "http://127.0.0.1:8000";
  static const int timeoutSec = 10;
  static late String? cookie;

  static Future<bool> login({
    required String email,
    required String password,
  }) {
    final url = Uri.parse('$baseUrl/users/login');

    return http
        .post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
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

  static Future<bool> signUp() {
    final url = Uri.parse('$baseUrl/users/signup');

    return http
        .post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': LoginScreen.user.email,
        'password': LoginScreen.user.password,
        'phone_no': LoginScreen.user.phoneNo,
        'user_type': '',
        'sex': '',
        'age': int.parse(LoginScreen.user.age),
        'nickname': LoginScreen.user.name,
        'name': LoginScreen.user.name,
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

  static Future<bool> emailSend(String email) {
    final url = Uri.parse('$baseUrl/users/mailsend');

    return http
        .post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({'email': email}),
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

  static Future<bool> emailVerify(String email, String code) async {
    final url = Uri.parse('$baseUrl/users/mailverify');
    return await http
        .post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'email': email,
        'user_code': code,
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
