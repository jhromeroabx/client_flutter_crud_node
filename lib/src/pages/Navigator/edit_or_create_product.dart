import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../dto/responseDTO/product.dart';
import '../../provider/app_state_provider.dart';
import '../../provider/entities_provider.dart';
import '../../utils/my_colors.dart';
import '../../widgets/input_data_text_field.dart';

class EditOrCreateProduct extends StatefulWidget {
  const EditOrCreateProduct({Key? key}) : super(key: key);

  @override
  State<EditOrCreateProduct> createState() => _EditOrCreateProductState();
}

class _EditOrCreateProductState extends State<EditOrCreateProduct> {
  TextEditingController controlNombreProduct = TextEditingController();
  TextEditingController controlComentario = TextEditingController();
  TextEditingController controlCantidad = TextEditingController();
  TextEditingController controlPrecio = TextEditingController();
  // r'(?=.*?\d)^(([1-9]\d{0,2}(\' + this.thousandsSeparator + '\\d{3})*)|\\d+)?(\\' + this.decimalSeparator + '\\d{2})?\$'
  // CATEGORIA
  // ACTIVE
  TextEditingController barCode = TextEditingController();
  TextEditingController imagen_url = TextEditingController();

  int idCategoria = 0;
  bool active = true;
  List<DropdownMenuItem> dropDownMenuItems = [];

  bool _value = true;

  @override
  void initState() {
    super.initState();
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

    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Stack(children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 30),
              child: Column(
                children: [
                  _productImage(entitiesProvider.productSelected.imagen_url!),
                  TextDataBasic(
                      label: 'Nombre',
                      icon: Icons.card_giftcard,
                      maxLength: 50,
                      type: TextInputType.name,
                      controller: controlNombreProduct),
                  TextDataBasic(
                      label: 'Comentario',
                      icon: Icons.comment_bank_outlined,
                      maxLength: 50,
                      type: TextInputType.name,
                      controller: controlComentario),
                  _txtDatosQuantityOrPrice(
                    'Cantidad',
                    Icons.format_list_numbered_rounded,
                    9,
                    TextInputType.number,
                    controlCantidad,
                    onlyNumbers: true,
                  ),
                  _txtDatosQuantityOrPrice(
                    'Precio',
                    Icons.monetization_on,
                    10,
                    TextInputType.number,
                    controlPrecio,
                    twoDecimals: true,
                  ),
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

                      idCategoria = idCategoria == 0
                          ? appStateProvider.categorias!.categorias![0].id!
                          : idCategoria;

                      print("VALUE CURRENT: $idCategoria");

                      return comboBox(dropDownMenuItems);
                    }
                  }),
                  _switchProduct()
                  //falta barcode
                  //falta imagen url
                  // _buttomRegistrar(entitiesProvider, appStateProvider),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _switchProduct() {
    return CupertinoSwitch(
      value: _value,
      onChanged: (newValue) {
        setState(() {
          _value = newValue;
          print("VALUE SWITCH: $_value");
        });
      },
    );
  }

  Widget _productImage(String imagen_url) {
    // return Container(
    //   height: 170,
    //   width: 250,
    //   decoration: BoxDecoration(
    //     color: MyColors.secondaryColorOpacity,
    //     borderRadius: BorderRadius.circular(25),
    //   ),
    //   child: Image.network(imagen_url),
    // );
    return Container(
      height: 250,
      child: Image.network(
        imagen_url,
        // fit: BoxFit.cover,
      ),
    );
  }

  Widget _txtDatosQuantityOrPrice(String label, IconData icon, int maxLength,
      TextInputType type, TextEditingController controller,
      {bool onlyNumbers = false, bool twoDecimals = false}) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: MyColors.secondaryColorOpacity,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        // readOnly: true,
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

  void changedDropDownItem(dynamic value) {
    setState(() {
      idCategoria = value;
    });
  }

  Container comboBox(List<DropdownMenuItem> items) {
    if (items.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.blueAccent, width: 4)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
              iconSize: 50,
              isExpanded: true,
              value: idCategoria,
              items: items,
              onChanged: changedDropDownItem),
        ),
      );
    } else {
      return Container(color: Colors.blue, child: const Text("NO TYPE"));
    }
  }
}
