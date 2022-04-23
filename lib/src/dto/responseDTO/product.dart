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
  bool? active;
  String? barcode;
  String? imagen_url;
  String? categoria;

  Product({
    this.id,
    this.nombre,
    this.comentario,
    this.cantidad,
    this.precio,
    this.idCategoria,
    this.active,
    this.barcode,
    this.imagen_url,
    this.categoria,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        nombre: json["nombre"],
        comentario: json["comentario"],
        cantidad: json["cantidad"],
        precio: json["precio"].toDouble(),
        idCategoria: json["id_categoria"],
        active: json["active"] == 0 ? false : true,
        barcode: json["barcode"],
        imagen_url: json["imagen_url"],
        categoria: json["categoria"],
      );

  Map<String, dynamic> toJson() => {
        "id": id ?? 0,
        "nombre": nombre,
        "comentario": comentario,
        "cantidad": cantidad,
        "precio": precio,
        "id_categoria": idCategoria,
        "active": active,
        "barcode": barcode,
        "imagen_url": imagen_url,
        "categoria": categoria,
      };
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
