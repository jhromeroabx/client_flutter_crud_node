import 'dart:convert';

import 'package:client_flutter_crud_node/src/dto/employee.dart';
import 'package:http/http.dart' as http;

class EmployeeService {
  static const String _apiHost = "192.168.18.5:5000";
  static const String _routePath_getAllUser = "/getAllEmployee";
  static const String _routePath_getAllEmplopyeeType = "/getAllEmployeeType";
  static const String _routePath_getUserByID = "/findEmployee/";
  static const String _routePath_deleteUserByID = "/deleteEmployee/";
  static const String _routePath_addEmployeeOrEdit = "/AddEmployeeOrEdit/";

  EmployeeService();

  Future<EmployeeList?> getAllUsers() async {
    try {
      final response =
          await http.get(Uri.http(_apiHost, _routePath_getAllUser));
      print("API" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return EmployeeList.fromMap(response.body);
      }
    } catch (e) {
      print("ERROR $_routePath_getAllUser: $e");
    }
    return null;
  }

  Future<EmployeeTypeList?> getAllEmployeeTypes() async {
    try {
      final response =
          await http.get(Uri.http(_apiHost, _routePath_getAllEmplopyeeType));
      print("API" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return EmployeeTypeList.fromMap(response.body);
      }
    } catch (e) {
      print("ERROR $_routePath_getAllEmplopyeeType: $e");
    }
    return null;
  }

  Future<Employee?> getUsersById(int id) async {
    try {
      final response = await http.get(
        Uri.http(
          _apiHost,
          (_routePath_getUserByID + id.toString()),
        ),
      );
      print("API" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return Employee.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("ERROR $_routePath_getUserByID: $e");
    }
    return null;
  }

  Future<bool> deleteUserById(int id) async {
    try {
      final response = await http.delete(
        Uri.http(
          _apiHost,
          (_routePath_deleteUserByID + id.toString()),
        ),
      );
      print("API" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print("ERROR $_routePath_deleteUserByID: $e");
    }
    return false;
  }

  Future<bool> addEmployeeOrEdit(Employee employee) async {
    try {
      final response = await http.post(
        Uri.http(
          _apiHost,
          (_routePath_addEmployeeOrEdit),
        ),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(employee.toJson()),
      );
      print("API" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      print("ERROR $_routePath_addEmployeeOrEdit: $e");
    }
    return false;
  }
}
