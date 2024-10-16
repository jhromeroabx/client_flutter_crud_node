import 'dart:convert';
import 'package:http/http.dart' as http;

import '../dto/responseDTO/product.dart';
import '../dto/responseDTO/UiResponse.dart';
import 'config_host.dart';

class ProductService {
  final String _apiHost = AppData().hostNodeServer;
  static const String _routePath_getAllCategory = "/getAllCategory";
  static const String _routePath_getAllProducts = "/getAllProducts";
  static const String _routePath_findProductBy = "/findProductBy";
  static const String _routePath_disableProductBy = "/disableProductBy";
  static const String _routePath_productoAddOrEdit = "/productoAddOrEdit";

  ProductService();

  Future<List<Product>?> getAllProducts(String id_categoria, int active) async {
    try {
      var headers = {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'id_categoria': id_categoria,
        'active': active,
      });

      final response = await http.post(
          Uri.http(_apiHost, _routePath_getAllProducts),
          headers: headers,
          body: body);
      print("API" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return Products.fromMap(response.body).products;
      }
    } catch (e) {
      print("ERROR $_routePath_getAllProducts: $e");
      return null;
    }
  }

  Future<Product?> findProductBy(String? id, String? barcode) async {
    try {
      var headers = {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode({
        'id': id,
        'barcode': barcode,
      });

      final response = await http.post(
          Uri.http(_apiHost, _routePath_findProductBy),
          headers: headers,
          body: body);

      print("API" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return Product.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      print("ERROR $_routePath_findProductBy: $e");
      return null;
    }
  }

  Future<Categorias?> getAllCategory() async {
    try {
      var headers = {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      };

      final response = await http.get(
        Uri.http(_apiHost, _routePath_getAllCategory),
        headers: headers,
      );
      print("API" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return Categorias.fromMap(response.body);
      }
    } catch (e) {
      print("ERROR $_routePath_getAllCategory: $e");
      return null;
    }
  }

  Future<UiResponse?> registerOrEditProduct(Product product) async {
    try {
      var headers = {
        'accept': 'text/plain',
        'Content-Type': 'application/json',
      };

      final body = jsonEncode(product);

      final response = await http.post(
        Uri.http(_apiHost, _routePath_productoAddOrEdit),
        headers: headers,
        body: body,
      );
      print("API" + response.statusCode.toString());
      if (response.statusCode == 200) {
        return UiResponse.fromMap(jsonDecode(response.body));
      }
    } catch (e) {
      print("ERROR $_routePath_productoAddOrEdit: $e");
      return null;
    }
  }
}
