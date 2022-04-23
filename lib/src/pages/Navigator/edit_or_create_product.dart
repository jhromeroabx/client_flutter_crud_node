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

  bool? _value;

  late String _registerOrUpdate = "REGISTRAR";

  @override
  void initState() {
    super.initState();
  }

  loadProductData(EntitiesProvider entitiesProvider) {
    if (entitiesProvider.productSelected != null) {
      final productSelected = entitiesProvider.productSelected;

      // controlComentario.text = productSelected!.comentario!;
      controlNombreProduct.text = controlNombreProduct.text.isEmpty
          ? productSelected!.nombre!
          : controlNombreProduct.text;

      controlComentario.text = controlComentario.text.isEmpty
          ? productSelected!.comentario!
          : controlComentario.text;

      controlCantidad.text = controlCantidad.text.isEmpty
          ? productSelected!.cantidad!.toString()
          : controlCantidad.text;

      controlPrecio.text = controlPrecio.text.isEmpty
          ? productSelected!.precio!.toString()
          : controlPrecio.text;

      barCode.text = barCode.text.isEmpty
          ? productSelected!.barcode!.toString()
          : barCode.text;

      imagen_url.text = imagen_url.text.isEmpty
          ? productSelected!.imagen_url!.toString()
          : imagen_url.text;

      _registerOrUpdate = "ACTUALIZAR";
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

    loadProductData(entitiesProvider);

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
                  // if (entitiesProvider.productSelected != null)
                  _productImage(entitiesProvider.productSelected == null
                      ? null
                      : entitiesProvider.productSelected!.imagen_url),
                  TextDataBasic(
                      size: 100,
                      label: 'Nombre',
                      icon: Icons.card_giftcard,
                      maxLength: 50,
                      type: TextInputType.name,
                      controller: controlNombreProduct),
                  TextDataBasic(
                      label: 'Comentario',
                      size: 200,
                      maxLines: null,
                      icon: Icons.comment_bank_outlined,
                      maxLength: 200,
                      type: TextInputType.multiline,
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
                  _switchProduct(entitiesProvider),
                  TextDataBasic(
                    size: 100,
                    label: 'Codigo de barras',
                    icon: Icons.document_scanner_outlined,
                    maxLength: 50,
                    type: TextInputType.number,
                    controller: barCode,
                    readOnly: true,
                  ),
                  TextDataBasic(
                    label: 'URL imagen',
                    size: 150,
                    maxLines: null,
                    icon: Icons.card_giftcard,
                    // maxLength: 50,
                    type: TextInputType.name,
                    controller: imagen_url,
                    iconSuffix: Icons.delete_forever_sharp,
                    colorIconSuffix: Colors.red,
                    onTapSuffix: () {
                      imagen_url.clear();
                    },
                  ),
                  //falta barcode
                  //falta imagen url
                  _buttomRegistrarOrUpdate(),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _buttomRegistrarOrUpdate() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 15),
            primary: MyColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25))),
        onPressed: () async {
          if (validarCamposVacios()) {
          } else {}
        },
        child: Text(
          _registerOrUpdate,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _switchProduct(EntitiesProvider entitiesProvider) {
    if (entitiesProvider.productSelected == null) {
      _value = _value ?? true;
    } else {
      _value = _value ?? entitiesProvider.productSelected!.active!;
    }
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: MyColors.secondaryColorOpacity,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Habilitado: ",
            style: TextStyle(fontSize: 20),
          ),
          CupertinoSwitch(
            value: _value!,
            onChanged: (newValue) {
              setState(() {
                _value = newValue;
                print("VALUE SWITCH: $_value");
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _productImage(String? imagen_url) {
    return FadeInImage.assetNetwork(
      height: 300,
      width: 300,
      fadeInDuration: const Duration(milliseconds: 500),
      fadeInCurve: Curves.easeInExpo,
      fadeOutCurve: Curves.easeOutExpo,
      placeholder: 'assets/images/gallery.jpg',
      image:
          imagen_url ?? 'https://shpl.info/sites/default/files/2020-11/new.jpg',
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          "assets/images/gallery.jpg",
          height: 300,
          width: 300,
        );
      },
      fit: BoxFit.contain,
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
        height: 80,
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
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
                  isExpanded: true,
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

  bool validarCamposVacios() {
    //ADD
    //id = 0
    //nombre
    //comentario
    //barcode (solo con camera) NULL
    //imagen_url NULL
    //id_categoria

    //edit
    //id = id_real

    String controlApellidoText = controlNombreProduct.text.trim();
    String controlDNIText = controlDNI.text.trim();
    String controlTelefonoText = controlTelefono.text.trim();
    String controlEmailText = controlEmail.text.trim();
    String controlContrasenaText = controlContrasena.text.trim();

    return true;
  }
}
