import 'package:flutter/material.dart';

import '../apis/product_service.dart';
import '../dto/responseDTO/UiResponse.dart';
import '../dto/responseDTO/product.dart';

class ProductProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  List<Product>? lista_products;

  Future<bool> getAllProducts(String id_categoria, int active) async {
    lista_products =
        await ProductService().getAllProducts(id_categoria, active);
    if (lista_products != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<FindProduct?> getProductByIdOrBarCode(
      {String? id, String? barcode}) async {
    FindProduct? rpta = await ProductService().findProductBy(id, barcode);
    return rpta;
  }

  Future<List<Object>> productAddOrEdit(Product product) async {
    isLoading = true;

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
