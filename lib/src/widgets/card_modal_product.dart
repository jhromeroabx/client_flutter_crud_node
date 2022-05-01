import 'package:animate_do/animate_do.dart';
import 'package:client_flutter_crud_node/src/widgets/flush_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../dto/requestDTO/product_selected.dart';
import '../provider/products_in_out_provider.dart';
import '../utils/my_colors.dart';

class CardModalProduct extends StatefulWidget {
  const CardModalProduct({Key? key}) : super(key: key);

  @override
  State<CardModalProduct> createState() => _CardModalProductState();
}

class _CardModalProductState extends State<CardModalProduct> {
  TextEditingController controlCantidad = TextEditingController();

  TextEditingController controlPrecio = TextEditingController();

  loadData(ProductsInOutProvider productsInOutProvider) {
    var product = productsInOutProvider.productSelectedTemp!;

    controlCantidad.text = controlCantidad.text.isEmpty
        ? "${product.cantidadSelected}"
        : controlCantidad.text;

    controlPrecio.text = controlPrecio.text.isEmpty
        ? "${product.precioCompra!}"
        : controlCantidad.text;
  }

  @override
  Widget build(BuildContext context) {
    var productSelectedProvider = Provider.of<ProductsInOutProvider>(context);

    return SafeArea(
      top: true,
      right: false,
      bottom: true,
      left: false,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color.fromARGB(137, 4, 40, 82),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
            ),
            SingleChildScrollView(
              child: ZoomIn(
                duration: const Duration(milliseconds: 300),
                child: Container(
                  height: 300,
                  // margin: const EdgeInsets.symmetric(horizontal: 30),
                  width: MediaQuery.of(context).size.width * 0.7,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 100,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: const [
                          Text("Ingrese Precio y Cantidad"),
                        ],
                      ),
                      _txtDatosQuantityOrPrice(
                        'Cantidad',
                        Icons.format_list_numbered_rounded,
                        9,
                        TextInputType.number,
                        controlCantidad,
                        onlyNumbers: true,
                        // read: true,
                      ),
                      _txtDatosQuantityOrPrice(
                        'Precio',
                        Icons.monetization_on,
                        10,
                        TextInputType.number,
                        controlPrecio,
                        twoDecimals: true,
                        // read: true,
                      ),
                      _buttomRegistrarOrUpdate(productSelectedProvider)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _txtDatosQuantityOrPrice(String label, IconData icon, int maxLength,
      TextInputType type, TextEditingController controller,
      {bool onlyNumbers = false, bool twoDecimals = false, bool read = false}) {
    return Container(
      height: 80,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: MyColors.secondaryColorOpacity,
          // borderRadius: BorderRadius.circular(25),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          )),
      child: TextField(
        readOnly: read,
        style: const TextStyle(fontSize: 20),
        controller: controller,
        maxLength: maxLength,
        keyboardType: type,
        inputFormatters: [
          if (twoDecimals && onlyNumbers == false)
            //FUNCIONA  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$')),
            //https://www.debuggex.com/r/4OwPfvp8lhwV_GZC
            //https://regex101.com/
            //FUNCIONA con 2 decimales
            FilteringTextInputFormatter.allow(
                RegExp(r'^\d+((.)|(.\d{0,2})?)$')),
          if (onlyNumbers && twoDecimals == false)
            FilteringTextInputFormatter.digitsOnly
        ],
        decoration: InputDecoration(
          border: InputBorder.none,
          // hintText: hintText,
          hintStyle: TextStyle(
            color: MyColors.primaryColor,
          ),
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Widget _buttomRegistrarOrUpdate(
      ProductsInOutProvider productSelectedProvider) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        onPressed: () async {
          if (controlCantidad.text.trim().isNotEmpty ||
              controlPrecio.text.trim().isNotEmpty) {
            ProductSelected updateProduct =
                productSelectedProvider.productSelectedTemp!;
            updateProduct.cantidadSelectedSet = int.parse(controlCantidad.text);
            updateProduct.precioCompraSet = double.parse(controlPrecio.text);

            int rpta =
                productSelectedProvider.putProductInBuckert(updateProduct);
            switch (rpta) {
              case 1:
                FlushBar().snackBarV2(
                    "Producto Actualizado!", Colors.indigo[900]!, context);
                break;
            }
          }
        },
        child: const Text(
          "REGISTRAR",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
