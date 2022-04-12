import 'dart:convert';
import 'package:http/http.dart' as http;

import '../dto/login.dart';

class UserService {
  static const String _apiHost = "192.168.18.5:5000";
  static const String _routePath_login = "/login";

  UserService();

  Future<Login?> login(String user, String contrasenia) async {
    try {
      var headers = {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      };
      UserLoginBody userLoginBody =
          UserLoginBody(user: user, contrasenia: contrasenia);
      // final body = jsonEncode({
      //   "user": user,
      //   "contrasenia": contrasenia,
      // });
      final body = jsonEncode(userLoginBody);

      final response = await http.post(
        Uri.http(_apiHost, _routePath_login),
        headers: headers,
        body: body,
      );
      print("API" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return Login.fromMap(jsonDecode(response.body));
      }
    } catch (e) {
      print("ERROR $_routePath_login: $e");
      return null;
    }
  }
}
