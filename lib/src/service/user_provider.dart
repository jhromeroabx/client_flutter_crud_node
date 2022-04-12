import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../apis/user_service.dart';
import '../dto/login.dart';

class UserProvider extends ChangeNotifier {
  //IS LOADING
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  } //IS LOADING

  Login? userAcceso;

  UserProvider();

  Future<List<Object>> accessLogin(String user, String contrasenia) async {
    _isLoading = true;

    userAcceso = await UserService().login(user, contrasenia);

    if (userAcceso != null) {
      isLoading = false;
      if (userAcceso!.userData != null) {
        Fluttertoast.showToast(
            msg: 'ACCESS',
            fontSize: 20,
            textColor: Colors.white,
            backgroundColor: Colors.green);
        return [1, "Ingresando al Sistema"];
      } else {
        Fluttertoast.showToast(
            msg: 'ACCESS DENIED',
            fontSize: 20,
            textColor: Colors.white,
            backgroundColor: Colors.red);
        return [2, "Accesos denegados!!!"];
      }
    } else {
      isLoading = false;
      Fluttertoast.showToast(
          msg: 'NO DATA!!!',
          fontSize: 20,
          textColor: Colors.white,
          backgroundColor: Colors.red);
      return [3, "Error del servidor!!!"];
    }
  }
}
