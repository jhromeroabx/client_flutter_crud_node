import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../apis/employee_service.dart';
import '../dto/responseDTO/employee.dart';

class AppStateProvider extends ChangeNotifier {
  //IS LOADING
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  } //IS LOADING

  AppStateProvider();

  EmployeeTypeList? employeeTypeListService;

  Future getAllEmployeeTypes() async {
    _isLoading = true;

    employeeTypeListService = await EmployeeService().getAllEmployeeTypes();
    //notifyListeners();

    if (employeeTypeListService != null) {
      isLoading = false;
    } else {
      isLoading = false;
      return;
    }
  }
}
