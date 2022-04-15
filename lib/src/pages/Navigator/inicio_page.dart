import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../dto/responseDTO/product.dart';
import '../../provider/entities_provider.dart';
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

    return SingleChildScrollView(
      child: Column(children: [
        Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(20),
          child: const Text("TODOS LOS PRODUCTOS"),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: itemsCount,
            itemBuilder: (BuildContext context, int index) {
              Product pro = entitiesProvider.products!.products![index];
              return CardCustomType2(
                imageURL: pro.imagen_url!,
                name: pro.nombre,
              );
              // return ListTile(
              //     leading: const Icon(Icons.list),
              //     trailing: const Text(
              //       "GFG",
              //       style: TextStyle(color: Colors.green, fontSize: 15),
              //     ),
              //     title: Text("List item $index"));
            }),
      ]),
    );
  }
}
