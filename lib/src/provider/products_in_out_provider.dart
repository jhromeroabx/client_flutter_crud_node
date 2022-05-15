import 'package:client_flutter_crud_node/src/dto/requestDTO/product_selected.dart';
import 'package:flutter/material.dart';

class ProductsInOutProvider extends ChangeNotifier {
  //IS LOADING
  bool _isActiveModal = false;
  bool get isActiveModal => _isActiveModal;
  set isActiveModal(value) {
    _isActiveModal = value;
    notifyListeners();
  } //IS LOADING

  Map<int, ProductSelected> bucketProductSelected = {};

  void cleanShoppingCart() {
    bucketProductSelected = {};
  }

  int putProductInBucket(ProductSelected productSelected) {
    if (bucketProductSelected[productSelected.id] == null) {
      bucketProductSelected[productSelected.id!] = productSelected;
      notifyListeners();
      return 1; //todo bien
    } else {
      bucketProductSelected[productSelected.id!] = productSelected;
      notifyListeners();
      return 2; //ya existia, se actualizo
    }
  }

  bool quitProductInBucket(ProductSelected productSelected) {
    if (bucketProductSelected[productSelected.id] == null) {
      return false; //no existe el producto
    } else {
      bucketProductSelected.remove(productSelected.id!);
      notifyListeners();
      return true; //se borro con exito
    }
  }
}
