import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../../dto/requestDTO/product_selected.dart';
import '../../provider/entities_provider.dart';
import '../../provider/products_in_out_provider.dart';
import '../../widgets/card_modal_product.dart';
import '../../widgets/card_products.dart';
import '../../widgets/flush_bar.dart';

class IngresoAlmacen extends StatefulWidget {
  const IngresoAlmacen({Key? key}) : super(key: key);

  @override
  State<IngresoAlmacen> createState() => _IngresoAlmacenState();
}

class _IngresoAlmacenState extends State<IngresoAlmacen> {
  ProductSelected? productSelectedTempSet;

  @override
  Widget build(BuildContext context) {
    var entitiesProvider = Provider.of<EntitiesProvider>(context);
    var productSelectedProvider = Provider.of<ProductsInOutProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            margin:
                const EdgeInsets.only(left: 2, right: 2, top: 150, bottom: 10),
            height: double.infinity,
            child: ListView(
              children: [
                if (productSelectedProvider.bucketProductSelected.isEmpty)
                  Center(
                    child: ProductItems(
                      color: Colors.red[100],
                      imageURL: "",
                      name: "No hay productos seleccionados!",
                      ancho: 250,
                    ),
                  ),
                if (productSelectedProvider.bucketProductSelected.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 32,
                      runSpacing: 10,
                      children: [
                        for (var key in productSelectedProvider
                            .bucketProductSelected.keys)
                          GestureDetector(
                            onTap: () {
                              productSelectedProvider.isActiveModal = true;
                              Fluttertoast.showToast(msg: "TEST ITEM MODAL");
                              //OPEN MODAL
                              //FOR CANTIDAD & PRECIO GLOBAL

                              //pasamos el producto del bucle
                              setState(() {
                                productSelectedTempSet = productSelectedProvider
                                    .bucketProductSelected[key]!;
                              });

                              //INTERACTURAR CON EL MAP
                              //contador de map map.lenght
                              //remove map.remove(key);
                            },
                            child: ProductItems(
                              counterShow: true,
                              imageURL: productSelectedProvider
                                  .bucketProductSelected[key]!.imagenUrl,
                              name: productSelectedProvider
                                  .bucketProductSelected[key]!.nombre,
                              counterCantidad: productSelectedProvider
                                  .bucketProductSelected[key]!
                                  .cantidadSelected!,
                            ),
                          ),
                      ],
                    ),
                  )
              ],
            ),
          ),
          Positioned(
            left: MediaQuery.of(context).size.width * 0.05,
            top: 10,
            child: Container(
              height: 120,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blue.withOpacity(0.3),
              ),
              child: Center(
                child: Text(
                  "${productSelectedProvider.bucketProductSelected.length}" +
                      "\n Productos Seleccionados",
                  style: const TextStyle(fontSize: 30),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Positioned(
            right: 15,
            top: 80,
            child: buttonIngresoAlmacen(productSelectedProvider),
          ),
          Positioned(
            right: 15,
            bottom: 80,
            child: buttomCamera(entitiesProvider, productSelectedProvider),
          ),
          // Positioned(
          //   right: 10,
          //   bottom: 10,
          //   child: buttomCameraV2(entitiesProvider),
          // ),
          Visibility(
            visible: productSelectedProvider.isActiveModal,
            child: WillPopScope(
              child: CardModalProduct(productSelectedTempSet),
              onWillPop: () async {
                productSelectedProvider.isActiveModal = false;
                return false;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buttomCamera(EntitiesProvider entitiesProvider,
      ProductsInOutProvider productSelectedProvider) {
    return FloatingActionButton(
      isExtended: true,
      onPressed: () async {
        try {
          //abri la camara de codigo de barra
          await Permission.camera.request();
          String? barcode = await scanner.scan();
          if (mounted) {
            FlushBar().snackBarV2("$barcode", Colors.blue, context,
                milliseconds: 5000);
          }

          if (barcode == null) {
            if (mounted) {
              FlushBar().snackBarV2("No hay codigo!", Colors.red, context);
            }
          } else {
            // barcode;

            var rpta = entitiesProvider.getProductByIdOrBarCode(
                id: "", barcode: barcode);
            rpta.then((value) async {
              if (value != null) {
                //agregar producto en el MAP

                ProductSelected productSelected = ProductSelected(
                  id: value.id,
                  imagenUrl: value.imagen_url,
                  nombre: value.nombre,
                  cantidadSelected: 0,
                  precioCompra: 0,
                );

                int rpta =
                    productSelectedProvider.putProductInBucket(productSelected);
                switch (rpta) {
                  case 2:
                    FlushBar().snackBarV2("El producto ya esta seleccionado",
                        Colors.purple[900]!, context);
                    break;
                  default:
                }
              } else {
                if (mounted) {
                  FlushBar()
                      .snackBarV2("No cargo el producto!", Colors.red, context);
                }
              }
            });
          }
        } catch (e) {
          if (mounted) {
            FlushBar().snackBarV2("Error: $e", Colors.red, context);
          }
        }
      },
      child: const Icon(
        Icons.camera_alt_rounded,
        size: 40,
      ),
      backgroundColor: Colors.green[700],
      tooltip: "BUSCAR POR CODIGO DE BARRA",
    );
  }

  Widget buttonIngresoAlmacen(ProductsInOutProvider productsInOutProvider) {
    return FloatingActionButton(
      onPressed: () {
        var res = productsInOutProvider.sendCompraSerial();
        res.then((value) {
          if (value[0] == 1) {
            Fluttertoast.showToast(msg: "${value[1]}");
          } else {
            Fluttertoast.showToast(
                msg: "${value[1]}", backgroundColor: Colors.red);
          }
        });
      },
      child: const Icon(Icons.add),
    );
  }
}
