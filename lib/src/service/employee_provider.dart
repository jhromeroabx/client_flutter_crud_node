import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../apis/employee_service.dart';
import '../dto/employee.dart';

class EmployeeProvider extends ChangeNotifier {
  //IS LOADING
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  } //IS LOADING

  EmployeeList? employeeListService;
  EmployeeTypeList? employeeTypeListService;
  Employee? employeeService;

  EmployeeProvider();

  Future getAllEmployeeTypes() async {
    _isLoading = true;

    employeeTypeListService = await EmployeeService().getAllEmployeeTypes();
    notifyListeners();

    // await Future.delayed(const Duration(seconds: 2));

    if (employeeTypeListService != null) {
      isLoading = false;
      Fluttertoast.showToast(
          msg: 'ALL EMPLOYEES WERE DOWNLOAD SUCCESFULLY',
          textColor: Colors.black,
          backgroundColor: Colors.greenAccent);
    } else {
      isLoading = false;
      Fluttertoast.showToast(
          msg: 'ALL EMPLOYEES WERE NOT DOWNLOAD SUCCESFULLY',
          backgroundColor: Colors.redAccent);
      return;
    }
  }

  Future getAllEmployee() async {
    _isLoading = true;

    employeeListService = await EmployeeService().getAllUsers();
    notifyListeners();

    // await Future.delayed(const Duration(seconds: 2));

    if (employeeListService != null) {
      isLoading = false;
      Fluttertoast.showToast(
          msg: 'ALL EMPLOYEES WERE DOWNLOAD SUCCESFULLY',
          backgroundColor: Colors.greenAccent);
    } else {
      isLoading = false;
      Fluttertoast.showToast(
          msg: 'ALL EMPLOYEES WERE NOT DOWNLOAD SUCCESFULLY',
          backgroundColor: Colors.redAccent);
      return;
    }
  }

  Future getEmployeeById(int id) async {
    _isLoading = true;

    employeeService = await EmployeeService().getUsersById(id);
    notifyListeners();

    // await Future.delayed(const Duration(seconds: 2));

    if (employeeService != null) {
      isLoading = false;
      Fluttertoast.showToast(
          msg: 'THE EMPLOYEE WAS DOWNLOAD SUCCESFULLY',
          backgroundColor: Colors.greenAccent);
    } else {
      isLoading = false;
      Fluttertoast.showToast(
          msg: 'THE EMPLOYEE WAS NOT DOWNLOAD SUCCESFULLY',
          backgroundColor: Colors.redAccent);
      return;
    }
  }

  Future<bool> deleteEmployeeById(int id) async {
    _isLoading = true;

    bool rptaDelete = false;

    rptaDelete = await EmployeeService().deleteUserById(id);

    if (rptaDelete) {
      isLoading = false;
      getAllEmployee();
      Fluttertoast.showToast(
          msg: 'THE EMPLOYEE $id WAS DELETED SUCCESFULLY',
          backgroundColor: Colors.greenAccent);
      return true;
    } else {
      isLoading = false;
      Fluttertoast.showToast(
          msg: 'THE EMPLOYEE $id WAS NOT DELETED SUCCESFULLY',
          backgroundColor: Colors.redAccent);
      return false;
    }
  }

  Future<bool> addEmployeeOrEdit(Employee employee) async {
    _isLoading = true;

    bool rptaEditDelete = false;

    rptaEditDelete = await EmployeeService().addEmployeeOrEdit(employee);

    // await Future.delayed(const Duration(seconds: 2));

    if (rptaEditDelete) {
      isLoading = false;
      getAllEmployee();
      Fluttertoast.showToast(
          msg: 'THE EMPLOYEE WAS CREATED SUCCESFULLY',
          backgroundColor: Colors.greenAccent);
      return true;
    } else {
      isLoading = false;
      Fluttertoast.showToast(
          msg: 'THE EMPLOYEE WAS NOT CREATED SUCCESFULLY',
          backgroundColor: Colors.redAccent);
      return false;
    }
  }
}
