import 'package:client_flutter_crud_node/src/dto/requestDTO/product_selected.dart';
import 'package:flutter/material.dart';

class ProductsInOutProvider extends ChangeNotifier {
  ProductSelected? productSelectedTemp;

  set productSelectedTempSet(ProductSelected productSelected) {
    productSelectedTemp = productSelected;
    notifyListeners();
  }

  Map<int, ProductSelected> bucketProductSelected = {};

  int putProductInBuckert(ProductSelected productSelected) {
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
}
