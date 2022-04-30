import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;

import '../../provider/entities_provider.dart';
import '../../widgets/card_modal_product.dart';
import '../../widgets/card_products.dart';
import '../../widgets/flush_bar.dart';

class IngresoAlmacen extends StatefulWidget {
  const IngresoAlmacen({Key? key}) : super(key: key);

  @override
  State<IngresoAlmacen> createState() => _IngresoAlmacenState();
}

class _IngresoAlmacenState extends State<IngresoAlmacen> {
  Map<int, ProductSelected> bucketProductSelected = {};

  bool _showModalForCategory = false;

  @override
  Widget build(BuildContext context) {
    var entitiesProvider = Provider.of<EntitiesProvider>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 2, right: 2, top: 5, bottom: 2),
            height: double.infinity,
            child: ListView(
              children: [
                if (bucketProductSelected.isEmpty)
                  Center(
                    child: ProductItems(
                      color: Colors.red[100],
                      imageURL: "",
                      name:
                          "No hay productos seleccionados para registrar la compra!",
                      ancho: 300,
                    ),
                  ),
                if (bucketProductSelected.isNotEmpty)
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      direction: Axis.horizontal,
                      alignment: WrapAlignment.spaceEvenly,
                      spacing: 32,
                      runSpacing: 20,
                      children: [
                        for (var key in bucketProductSelected.keys)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _showModalForCategory = !_showModalForCategory;
                              });
                              Fluttertoast.showToast(msg: "TEST ITEM MODAL");
                              //OPEN MODAL
                              //FOR CANTIDAD & PRECIO GLOBAL

                              //store & get cantidad y precio
                              bucketProductSelected[key]!.cantidadSelected;
                              bucketProductSelected[key]!.precioCompra;

                              //INTERACTURAR CON EL MAP
                              //contador de map map.lenght
                              //remove map.remove(key);
                            },
                            child: ProductItems(
                              counterShow: true,
                              imageURL: bucketProductSelected[key]!.imagenUrl,
                              name: bucketProductSelected[key]!.nombre,
                              counterCantidad:
                                  bucketProductSelected[key]!.cantidadSelected!,
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
            bottom: 30,
            child: Container(
              height: 100,
              width: MediaQuery.of(context).size.width * 0.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.amber,
              ),
              child: const Center(
                child: Text("SUMARY MARKER !"),
              ),
            ),
          ),
          Positioned(
            right: 15,
            bottom: 80,
            child: buttomCamera(entitiesProvider),
          ),
          // Positioned(
          //   right: 10,
          //   bottom: 10,
          //   child: buttomCameraV2(entitiesProvider),
          // ),
          Visibility(
            visible: _showModalForCategory,
            child: WillPopScope(
              child: CardModalProduct(),
              onWillPop: () async {
                _showModalForCategory = false;
                setState(() {});
                return false;
              },
            ),
          ),
        ],
      ),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      //   floatingActionButton: Column(
      //     crossAxisAlignment: CrossAxisAlignment.end,
      //     mainAxisAlignment: MainAxisAlignment.end,
      //     children: [
      //       FloatingActionButton(
      //         isExtended: true,
      //         onPressed: () async {
      //           //abri la camara de codigo de barra
      //           await Permission.camera.request();
      //           String? barcode = await scanner.scan();
      //           if (barcode == null) {
      //             FlushBar().snackBarV2("No hay codigo!", Colors.red, context);
      //           } else {
      //             barcode;

      //             var rpta = entitiesProvider.getProductByIdOrBarCode(
      //                 id: "", barcode: barcode);
      //             rpta.then((value) async {
      //               if (value) {
      //                 //agregar producto en el MAP
      //                 setState(() {
      //                   ProductSelected productSelected = ProductSelected(
      //                     id: entitiesProvider.productSelected!.id,
      //                     imagenUrl: entitiesProvider.productSelected!.imagen_url,
      //                     nombre: entitiesProvider.productSelected!.nombre,
      //                     cantidadSelected: 0,
      //                     precioCompra: 0,
      //                   );
      //                   if (bucketProductSelected[productSelected.id] == null) {
      //                     bucketProductSelected[productSelected.id!] =
      //                         productSelected;
      //                   } else {
      //                     FlushBar().snackBarV2(
      //                         "El producto ya esta seleccionado",
      //                         Colors.purple[900]!,
      //                         context);
      //                   }
      //                 });
      //               } else {
      //                 FlushBar().snackBarV2(
      //                     "No cargo el producto!", Colors.red, context);
      //               }
      //             });
      //           }
      //         },
      //         child: const Icon(
      //           Icons.camera_alt_rounded,
      //           size: 40,
      //         ),
      //         backgroundColor: Colors.green[700],
      //         tooltip: "BUSCAR POR CODIGO DE BARRA",
      //       ),
      //       const SizedBox(
      //         height: 10,
      //       ),
      //       FloatingActionButton(
      //         onPressed: () async {
      //           //abri la camara de codigo de barra
      //           await Permission.camera.request();
      //           String? barcode = await scanner.scan();
      //           if (barcode == null) {
      //             FlushBar().snackBarV2("No hay codigo!", Colors.red, context);
      //           } else {
      //             barcode;

      //             var rpta = entitiesProvider.getProductByIdOrBarCode(
      //                 id: "", barcode: barcode);
      //             rpta.then((value) async {
      //               if (value) {
      //                 //agregar producto en el MAP
      //                 setState(() {
      //                   ProductSelected productSelected = ProductSelected(
      //                     id: entitiesProvider.productSelected!.id,
      //                     imagenUrl: entitiesProvider.productSelected!.imagen_url,
      //                     nombre: entitiesProvider.productSelected!.nombre,
      //                     cantidadSelected: 0,
      //                     precioCompra: 0,
      //                   );
      //                   if (bucketProductSelected[productSelected.id] == null) {
      //                     bucketProductSelected[productSelected.id!] =
      //                         productSelected;
      //                   } else {
      //                     FlushBar().snackBarV2(
      //                         "El producto ya esta seleccionado",
      //                         Colors.purple[900]!,
      //                         context);
      //                   }
      //                 });
      //               } else {
      //                 FlushBar().snackBarV2(
      //                     "No cargo el producto!", Colors.red, context);
      //               }
      //             });
      //           }
      //         },
      //         child: const Icon(
      //           Icons.find_in_page_outlined,
      //           size: 40,
      //         ),
      //         backgroundColor: Colors.indigo[700],
      //         tooltip: "BUSCAR POR NOMBRE O CATEGORIA",
      //       ),
      //     ],
      //   ),
    );
  }

  Widget buttomCamera(EntitiesProvider entitiesProvider) {
    return FloatingActionButton(
      isExtended: true,
      onPressed: () async {
        try {
          //abri la camara de codigo de barra
          await Permission.camera.request();
          String? barcode = await scanner.scan();
          FlushBar().snackBarV2("$barcode", Colors.red, context);
          if (barcode == null) {
            FlushBar().snackBarV2("No hay codigo!", Colors.red, context);
          } else {
            // barcode;

            var rpta = entitiesProvider.getProductByIdOrBarCode(
                id: "", barcode: barcode);
            rpta.then((value) async {
              if (value) {
                //agregar producto en el MAP
                setState(() {
                  ProductSelected productSelected = ProductSelected(
                    id: entitiesProvider.productSelected!.id,
                    imagenUrl: entitiesProvider.productSelected!.imagen_url,
                    nombre: entitiesProvider.productSelected!.nombre,
                    cantidadSelected: 0,
                    precioCompra: 0,
                  );
                  if (bucketProductSelected[productSelected.id] == null) {
                    bucketProductSelected[productSelected.id!] =
                        productSelected;
                  } else {
                    FlushBar().snackBarV2("El producto ya esta seleccionado",
                        Colors.purple[900]!, context);
                  }
                });
              } else {
                FlushBar()
                    .snackBarV2("No cargo el producto!", Colors.red, context);
              }
            });
          }
        } catch (e) {
          FlushBar().snackBarV2("Error: $e", Colors.red, context);
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

  Widget buttomCameraV2(EntitiesProvider entitiesProvider) {
    return FloatingActionButton(
      isExtended: true,
      onPressed: () async {
        //abri la camara de codigo de barra
        await Permission.camera.request();
        String? barcode = await scanner.scan();
        if (barcode == null) {
          FlushBar().snackBarV2("No hay codigo!", Colors.red, context);
        } else {
          barcode;

          var rpta = entitiesProvider.getProductByIdOrBarCode(
              id: "", barcode: barcode);
          rpta.then((value) async {
            if (value) {
              //agregar producto en el MAP
              setState(() {
                ProductSelected productSelected = ProductSelected(
                  id: entitiesProvider.productSelected!.id,
                  imagenUrl: entitiesProvider.productSelected!.imagen_url,
                  nombre: entitiesProvider.productSelected!.nombre,
                  cantidadSelected: 0,
                  precioCompra: 0,
                );
                if (bucketProductSelected[productSelected.id] == null) {
                  bucketProductSelected[productSelected.id!] = productSelected;
                } else {
                  FlushBar().snackBarV2("El producto ya esta seleccionado",
                      Colors.purple[900]!, context);
                }
              });
            } else {
              FlushBar()
                  .snackBarV2("No cargo el producto!", Colors.red, context);
            }
          });
        }
      },
      child: const Icon(
        Icons.find_in_page,
        size: 40,
      ),
      backgroundColor: Colors.indigo[700],
      tooltip: "BUSCAR POR CODIGO DE BARRA",
    );
  }
}

class ProductSelected {
  int? id;
  String? imagenUrl;
  String? nombre;
  int? cantidadSelected;
  double? precioCompra;

  ProductSelected({
    this.id,
    this.imagenUrl,
    this.nombre,
    this.cantidadSelected = 0,
    this.precioCompra,
  });
}
