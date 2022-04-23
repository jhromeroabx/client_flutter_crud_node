import 'package:client_flutter_crud_node/src/apis/product_service.dart';
import 'package:client_flutter_crud_node/src/dto/responseDTO/product.dart';
import 'package:client_flutter_crud_node/src/dto/responseDTO/UiResponse.dart';
import 'package:flutter/material.dart';
import '../apis/employee_service.dart';
import '../apis/user_service.dart';
import '../dto/requestDTO/user_request_dto.dart';
import '../dto/responseDTO/employee.dart';
import '../dto/responseDTO/login.dart';

class EntitiesProvider extends ChangeNotifier {
  //IS LOADING
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  } //IS LOADING

  EmployeeList? employeeListService;
  Employee? employeeService;

  Login? userAcceso;

  EntitiesProvider();

  Future<List<Object>> accessLogin(String user, String contrasenia) async {
    _isLoading = true;

    userAcceso = await UserService().login(user, contrasenia);

    if (userAcceso != null) {
      isLoading = false;
      if (userAcceso!.userData != null) {
        return [1, "Ingresando al Sistema"];
      } else {
        return [2, "Accesos denegados!!!"];
      }
    } else {
      isLoading = false;
      return [3, "Error del servidor!!!"];
    }
  }

  Future<List<Object>> registerUser(
      UserReqAddEditBody userReqAddEditBody) async {
    _isLoading = true;

    UiResponse? response =
        await UserService().registerOrEditUser(userReqAddEditBody);

    if (response != null) {
      isLoading = false;
      if (response.state == true) {
        return [1, "Registrado"];
      } else {
        return [2, response.response!.error!];
      }
    } else {
      isLoading = false;
      return [3, "Error del servidor!!!"];
    }
  }

////EMPLOYEE
  Future getAllEmployee() async {
    _isLoading = true;

    employeeListService = await EmployeeService().getAllUsers();
    notifyListeners();

    // await Future.delayed(const Duration(seconds: 2));

    if (employeeListService != null) {
      isLoading = false;
      // Fluttertoast.showToast(
      //     msg: 'ALL EMPLOYEES WERE DOWNLOAD SUCCESFULLY',
      //     backgroundColor: Colors.greenAccent);
    } else {
      isLoading = false;
      // Fluttertoast.showToast(
      //     msg: 'ALL EMPLOYEES WERE NOT DOWNLOAD SUCCESFULLY',
      //     backgroundColor: Colors.redAccent);
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
      // Fluttertoast.showToast(
      //     msg: 'THE EMPLOYEE WAS DOWNLOAD SUCCESFULLY',
      //     backgroundColor: Colors.greenAccent);
    } else {
      isLoading = false;
      // Fluttertoast.showToast(
      //     msg: 'THE EMPLOYEE WAS NOT DOWNLOAD SUCCESFULLY',
      //     backgroundColor: Colors.redAccent);
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
      // Fluttertoast.showToast(
      //     msg: 'THE EMPLOYEE $id WAS DELETED SUCCESFULLY',
      //     backgroundColor: Colors.greenAccent);
      return true;
    } else {
      isLoading = false;
      // Fluttertoast.showToast(
      //     msg: 'THE EMPLOYEE $id WAS NOT DELETED SUCCESFULLY',
      //     backgroundColor: Colors.redAccent);
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
      // Fluttertoast.showToast(
      //     msg: 'THE EMPLOYEE WAS CREATED SUCCESFULLY',
      //     backgroundColor: Colors.greenAccent);
      return true;
    } else {
      isLoading = false;
      // Fluttertoast.showToast(
      //     msg: 'THE EMPLOYEE WAS NOT CREATED SUCCESFULLY',
      //     backgroundColor: Colors.redAccent);
      return false;
    }
  }

  Products? products;
  Product? _productSelected;
  Product? get productSelected => _productSelected;
  set productSelected(product) {
    _productSelected = product;
  }

  Future<bool> getAllProducts() async {
    products = await ProductService().getAllProducts();

    if (products != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getProductByIdOrBarCode({int? id, String? barcode}) async {
    productSelected = await ProductService().findProductBy(id, barcode);

    if (productSelected != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<List<Object>> productAddOrEdit(Product product) async {
    _isLoading = true;

    UiResponse? response =
        await ProductService().registerOrEditProduct(product);

    if (response != null) {
      isLoading = false;
      if (response.state == true) {
        return [1, "Registrado"];
      } else {
        return [2, response.response!.error!];
      }
    } else {
      isLoading = false;
      return [3, "Error del servidor!!!"];
    }
  }
}
