import 'dart:convert';

class Products {
  List<Product>? products;

  Products({this.products});

  factory Products.fromMap(jsonArray) {
    final List<dynamic> dataList = jsonDecode(jsonArray);

    final products_temp = <Product>[];

    for (var element in dataList) {
      products_temp.add(Product.fromJson(element));
    }

    return Products(
      products: products_temp.isNotEmpty ? products_temp : null,
    );
  }
}

class Product {
  int? id;
  String? nombre;
  String? comentario;
  int? cantidad;
  double? precio;
  int? idCategoria;
  int? active;
  String? categoria;

  Product({
    this.id,
    this.nombre,
    this.comentario,
    this.cantidad,
    this.precio,
    this.idCategoria,
    this.active,
    this.categoria,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        nombre: json["nombre"],
        comentario: json["comentario"],
        cantidad: json["cantidad"],
        precio: json["precio"].toDouble(),
        idCategoria: json["id_categoria"],
        active: json["active"],
        categoria: json["categoria"],
      );
}

class Categorias {
  List<Categoria>? categorias;

  Categorias({this.categorias});

  factory Categorias.fromMap(jsonArray) {
    final List<dynamic> dataList = jsonDecode(jsonArray);

    final categorias_temp = <Categoria>[];

    for (var element in dataList) {
      categorias_temp.add(Categoria.fromJson(element));
    }

    return Categorias(
      categorias: categorias_temp.isNotEmpty ? categorias_temp : null,
    );
  }
}

class Categoria {
  int? id;
  String? nombre;
  String? comentario;
  int? active;
  Categoria({
    this.id,
    this.nombre,
    this.comentario,
    this.active,
  });

  factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["id"],
        nombre: json["nombre"],
        comentario: json["comentario"],
        active: json["active"],
      );
}
