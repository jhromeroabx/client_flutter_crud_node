import 'dart:convert';
import 'package:http/http.dart' as http;

import '../dto/responseDTO/login.dart';
import '../dto/requestDTO/user_request_dto.dart';
import '../dto/responseDTO/user.dart';
import 'config_host.dart';

class UserService {
  final String _apiHost = AppData().hostNodeServer;
  static const String _routePath_login = "/login";
  static const String _routePath_AddUserOrEdit = "/AddUserOrEdit";

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

  Future<UserResponse?> registerOrEditUser(
      UserReqAddEditBody userReqAddEditBody) async {
    try {
      var headers = {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode(userReqAddEditBody);

      final response = await http.post(
        Uri.http(_apiHost, _routePath_AddUserOrEdit),
        headers: headers,
        body: body,
      );
      print("API" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return UserResponse.fromMap(jsonDecode(response.body));
      }
    } catch (e) {
      print("ERROR $_routePath_AddUserOrEdit: $e");
      return null;
    }
    return null;
  }
}
