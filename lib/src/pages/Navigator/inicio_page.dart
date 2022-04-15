import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../dto/responseDTO/product.dart';
import '../../provider/entities_provider.dart';
import '../../utils/my_colors.dart';
import '../../widgets/card_products.dart';

class InicioApp extends StatefulWidget {
  const InicioApp({Key? key}) : super(key: key);

  @override
  State<InicioApp> createState() => _InicioAppState();
}

class _InicioAppState extends State<InicioApp> {
  @override
  Widget build(BuildContext context) {
    var entitiesProvider = Provider.of<EntitiesProvider>(context);
    int itemsCount = 0;
    List<Product> products = [];
    if (entitiesProvider.products!.products == null) {
      Fluttertoast.showToast(msg: "NO HAY DATA");
    } else {
      itemsCount = entitiesProvider.products!.products!.length;
      products = entitiesProvider.products!.products!;
    }

    return SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(25),
                margin: const EdgeInsets.only(top: 20, left: 15, bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.lightGreenAccent[100],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Text(
                  "TODOS LOS PRODUCTOS",
                  style: TextStyle(fontSize: 25),
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
                        ProductItems(
                          imageURL: pro.imagen_url!,
                          name: pro.nombre,
                          precio: pro.precio.toString(),
                          cantidad: pro.cantidad.toString(),
                        ),
                    ],
                  ),
                ),
            ],
          ),
        ));
  }
}
