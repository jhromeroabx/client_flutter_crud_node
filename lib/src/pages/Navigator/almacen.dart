import 'package:client_flutter_crud_node/src/widgets/flush_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dto/responseDTO/product.dart';
import '../../provider/app_state_provider.dart';
import '../../provider/entities_provider.dart';
import '../../utils/my_colors.dart';
import '../../widgets/card_products.dart';

class AlmacenGestion extends StatefulWidget {
  const AlmacenGestion({Key? key}) : super(key: key);

  @override
  State<AlmacenGestion> createState() => _AlmacenGestionState();
}

class _AlmacenGestionState extends State<AlmacenGestion> {
  int itemsCount = 0;
  List<Product> products = [];

  List<DropdownMenuItem> dropDownMenuItems = [];

  int idCategoria = 0;

  bool _value = true;
  EntitiesProvider? entitiesProviderField;

  void _getAllProducts(
      EntitiesProvider entitiesProvider, String idCategoria, int active) async {
    await entitiesProvider.getAllProducts(idCategoria, active);

    if (entitiesProvider.lista_products == null ||
        entitiesProvider.lista_products!.length == 0) {
      setState(() {
        itemsCount = 0;
        products = [];
      });
    } else {
      setState(() {
        itemsCount = entitiesProvider.lista_products!.length;
        products = entitiesProvider.lista_products!;
      });
    }
  }

  List<DropdownMenuItem> getMenuItems(List<Categoria> lista) {
    List<DropdownMenuItem> items = [];
    for (var item in lista) {
      items.add(DropdownMenuItem(
        value: item.id,
        child: Text(item.nombre!),
        onTap: () {},
      ));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    var entitiesProvider = Provider.of<EntitiesProvider>(context);
    entitiesProviderField = Provider.of<EntitiesProvider>(context);

//TIPICO ERROR DE REFRESCAR CADA RATO, SATURA APP
    // _getAllProducts(entitiesProvider);
    itemsCount = entitiesProvider.lista_products!.length;
    products = entitiesProvider.lista_products!;

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            child: RefreshIndicator(
              onRefresh: () async {
                _getAllProducts(entitiesProvider, "", _value == true ? 1 : 0);
              },
              child: Container(
                margin: const EdgeInsets.only(
                  // bottom: 50,
                  top: 10,
                  left: 2,
                  right: 2,
                ),
                // padding: const EdgeInsets.all(25),
                height: double.infinity,
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      // padding: const EdgeInsets.all(25),
                      // margin: EdgeInsets.only(top: 20, left: 15, bottom: 10),
                      decoration: BoxDecoration(
                        // color: Colors.lightGreenAccent[100],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Consumer<AppStateProvider>(
                            builder: (context, appStateProvider, child) {
                              if (appStateProvider.categorias == null) {
                                return Container(
                                  color: Colors.amber[200],
                                  child: const Text("Categorias Nulas"),
                                );
                              } else {
                                dropDownMenuItems = getMenuItems(
                                    appStateProvider.categorias!.categorias!);

                                if (entitiesProvider.productSelected != null) {
                                  //edit
                                  idCategoria = idCategoria == 0
                                      ? entitiesProvider
                                          .productSelected!.idCategoria!
                                      : idCategoria;
                                } else {
                                  //new
                                  idCategoria =
                                      idCategoria == 0 ? 1 : idCategoria;
                                }
                                print("COMBO: $idCategoria");
                                return comboBox(
                                    dropDownMenuItems, entitiesProvider);
                              }
                            },
                          ), 
                          _switchProduct(entitiesProvider)
                        ],
                      ),
                    ),
                    if (products.length == 0)
                      Center(
                        child: ProductItems(
                          color: Colors.red[100],
                          imageURL: "",
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
                                  var rpta =
                                      entitiesProvider.getProductByIdOrBarCode(
                                          id: "${pro.id}", barcode: "");
                                  rpta.then((value) async {
                                    if (value) {
                                      Navigator.pushNamed(
                                          context, "edit/create_product");
                                    } else {
                                      FlushBar().snackBarV2(
                                          "No cargo el objeto",
                                          Colors.red,
                                          context);
                                    }
                                  });
                                },
                                child: ProductItems(
                                  imageURL: pro.imagen_url,
                                  name: pro.nombre,
                                  precio: pro.precio.toString(),
                                  cantidad: pro.cantidad.toString(),
                                ),
                              ),
                          ],
                        ),
                      ),
                    const SizedBox(
                      height: 80,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          entitiesProvider.productSelected = null;
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

  void changedDropDownItem(dynamic value) {
    setState(() {
      idCategoria = value;

      itemsCount = 0;
      products = [];

      _getAllProducts(
          entitiesProviderField!, "$idCategoria", _value == true ? 1 : 0);
    });
  }

  Container comboBox(
      List<DropdownMenuItem> items, EntitiesProvider entitiesProvider) {
    if (items.isNotEmpty) {
      return Container(
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
        padding: const EdgeInsets.all(3),
        // padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: MyColors.primaryColor, width: 4)),
        child: Column(
          children: [
            const Text("Categoria"),
            DropdownButtonHideUnderline(
              child: DropdownButton(
                  iconSize: 50,
                  // isExpanded: true,
                  value: idCategoria,
                  items: items,
                  onChanged: changedDropDownItem),
            ),
          ],
        ),
      );
    } else {
      return Container(color: Colors.blue, child: const Text("NO TYPE"));
    }
  }

  Widget _switchProduct(EntitiesProvider entitiesProvider) {
    return Column(
      children: [
        const Text("Ver Activos:"),
        CupertinoSwitch(
          value: _value,
          onChanged: (newValue) {
            setState(() {
              _value = newValue;
              _getAllProducts(entitiesProvider, "", _value == true ? 1 : 0);
            });
          },
        ),
      ],
    );
  }
}
