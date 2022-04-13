import 'package:client_flutter_crud_node/src/dto/responseDTO/user.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../apis/user_service.dart';
import '../dto/requestDTO/user_request_dto.dart';
import '../dto/responseDTO/login.dart';

class UserProvider extends ChangeNotifier {
  //IS LOADING
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  } //IS LOADING

  Login? userAcceso;
  UserResponse? userResponse;

  UserProvider();

  Future<List<Object>> accessLogin(String user, String contrasenia) async {
    _isLoading = true;

    userAcceso = await UserService().login(user, contrasenia);

    if (userAcceso != null) {
      isLoading = false;
      if (userAcceso!.userData != null) {
        // Fluttertoast.showToast(
        //     msg: 'ACCESS',
        //     fontSize: 20,
        //     textColor: Colors.white,
        //     backgroundColor: Colors.green);
        return [1, "Ingresando al Sistema"];
      } else {
        // Fluttertoast.showToast(
        //     msg: 'ACCESS DENIED',
        //     fontSize: 20,
        //     textColor: Colors.white,
        //     backgroundColor: Colors.red);
        return [2, "Accesos denegados!!!"];
      }
    } else {
      isLoading = false;
      // Fluttertoast.showToast(
      //     msg: 'NO DATA!!!',
      //     fontSize: 20,
      //     textColor: Colors.white,
      //     backgroundColor: Colors.red);
      return [3, "Error del servidor!!!"];
    }
  }

  Future<List<Object>> registerUser(
      UserReqAddEditBody userReqAddEditBody) async {
    _isLoading = true;

    userResponse = await UserService().registerOrEditUser(userReqAddEditBody);

    if (userResponse != null) {
      isLoading = false;
      if (userResponse!.state == true) {
        // Fluttertoast.showToast(
        //     msg: 'ACCESS',
        //     fontSize: 20,
        //     textColor: Colors.white,
        //     backgroundColor: Colors.green);
        return [1, "Registrado"];
      } else {
        // Fluttertoast.showToast(
        //     msg: 'ACCESS DENIED',
        //     fontSize: 20,
        //     textColor: Colors.white,
        //     backgroundColor: Colors.red);
        return [2, userResponse!.response!.error!];
      }
    } else {
      isLoading = false;
      // Fluttertoast.showToast(
      //     msg: 'NO DATA!!!',
      //     fontSize: 20,
      //     textColor: Colors.white,
      //     backgroundColor: Colors.red);
      return [3, "Error del servidor!!!"];
    }
  }
}
