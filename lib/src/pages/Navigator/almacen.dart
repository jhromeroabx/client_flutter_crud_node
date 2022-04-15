import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../dto/responseDTO/product.dart';
import '../../provider/entities_provider.dart';
import '../../widgets/card_products.dart';

class AlmacenGestion extends StatefulWidget {
  const AlmacenGestion({Key? key}) : super(key: key);

  @override
  State<AlmacenGestion> createState() => _AlmacenGestionState();
}

class _AlmacenGestionState extends State<AlmacenGestion> {
  int itemsCount = 0;
  List<Product> products = [];

  void _getAllProducts(EntitiesProvider entitiesProvider) async {
    await entitiesProvider.getAllProducts();

    if (entitiesProvider.products!.products == null) {
      setState(() {
        itemsCount = 0;
        products = [];
      });
    } else {
      setState(() {
        itemsCount = entitiesProvider.products!.products!.length;
        products = entitiesProvider.products!.products!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var entitiesProvider = Provider.of<EntitiesProvider>(context);

//TIPICO ERROR DE REFRESCAR CADA RATO, SATURA APP
    // _getAllProducts(entitiesProvider);
    itemsCount = entitiesProvider.products!.products!.length;
    products = entitiesProvider.products!.products!;

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: RefreshIndicator(
              onRefresh: () async {
                _getAllProducts(entitiesProvider);
              },
              child: SizedBox(
                height: double.infinity,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(25),
                      margin:
                          const EdgeInsets.only(top: 20, left: 15, bottom: 10),
                      decoration: BoxDecoration(
                        color: Colors.lightGreenAccent[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        "TODOS LOS PRODUCTOS",
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                    if (itemsCount == 0)
                      Center(
                        child: ProductItems(
                          color: Colors.red[100],
                          imageURL: null,
                          name: "No hay productos que mostrar",
                          precio: "0",
                          cantidad: "0",
                        ),
                      ),
                    if (itemsCount != 0)
                      SizedBox(
                        width: double.infinity,
                        child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 32,
                          runSpacing: 20,
                          children: [
                            for (var pro in products)
                              GestureDetector(
                                onTap: () {
                                  entitiesProvider.productSelected = pro;
                                  Navigator.pushNamed(
                                      context, "edit/create_product");
                                },
                                child: ProductItems(
                                  imageURL: pro.imagen_url!,
                                  name: pro.nombre,
                                  precio: pro.precio.toString(),
                                  cantidad: pro.cantidad.toString(),
                                ),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, "edit/create_product");
        },
        child: const Icon(
          Icons.add_circle_outline_sharp,
          size: 40,
          color: Colors.green,
        ),
        elevation: 15,
        backgroundColor: Colors.green[100],
      ),
    );
  }
}
