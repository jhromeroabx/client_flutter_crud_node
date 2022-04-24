import 'package:flutter/material.dart';

import '../../dto/responseDTO/product.dart';
import '../../widgets/card_modal_product.dart';
import '../../widgets/card_products.dart';

class IngresoAlmacen extends StatefulWidget {
  const IngresoAlmacen({Key? key}) : super(key: key);

  @override
  State<IngresoAlmacen> createState() => _IngresoAlmacenState();
}

class _IngresoAlmacenState extends State<IngresoAlmacen> {
  Map<int, Product> bucketProduct = {};

  late bool _showModalForCategory = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            height: double.infinity,
            child: ListView(
              children: [
                if (bucketProduct.isEmpty)
                  Center(
                    child: ProductItems(
                      color: Colors.red[100],
                      imageURL: "",
                      name:
                          "No hay productos seleccionados para registrar la compra!",
                      ancho: 300,
                    ),
                  ),
                if (bucketProduct.isNotEmpty)
                  SizedBox(
                      width: double.infinity,
                      child: Wrap(
                          direction: Axis.horizontal,
                          alignment: WrapAlignment.spaceEvenly,
                          spacing: 32,
                          runSpacing: 20,
                          children: [
                            for (var key in bucketProduct.keys)
                              GestureDetector(
                                onTap: () {
                                  //INTERACTURAR CON EL MAP
                                  //contador de map map.lenght
                                },
                                child: Container(
                                  child: Text(
                                    "ITEM Seleccionado",
                                  ),
                                ),
                              ),
                          ]))
              ],
            ),
          ),
          Visibility(
              visible: _showModalForCategory,
              child: WillPopScope(
                child: const CardModalProduct(),
                onWillPop: () async {
                  _showModalForCategory = false;
                  setState(() {});
                  return false;
                },
              )),
          Positioned(
              left: MediaQuery.of(context).size.width * 0.05,
              bottom: 30,
              child: Container(
                height: 100,
                width: 100,
                color: Colors.amber,
                child: const Center(child: Text("MARKER!!!")),
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        isExtended: true,
        onPressed: () {
          //abri la camara de codigo de barra
        },
        child: const Icon(
          Icons.camera_alt_rounded,
          size: 40,
        ),
        backgroundColor: Colors.green[700],
        tooltip: "BUSCAR POR CODIGO DE BARRA",
      ),
    );
  }
}
