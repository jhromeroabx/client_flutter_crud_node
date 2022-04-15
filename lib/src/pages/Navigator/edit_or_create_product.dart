import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/entities_provider.dart';
import '../../utils/my_colors.dart';

class EditOrCreateProduct extends StatefulWidget {
  const EditOrCreateProduct({Key? key}) : super(key: key);

  @override
  State<EditOrCreateProduct> createState() => _EditOrCreateProductState();
}

class _EditOrCreateProductState extends State<EditOrCreateProduct> {
  TextEditingController controlNombre = TextEditingController();
  TextEditingController controlApellido = TextEditingController();
  TextEditingController controlDNI = TextEditingController();
  TextEditingController controlTelefono = TextEditingController();
  TextEditingController controlEmail = TextEditingController();
  TextEditingController controlContrasena = TextEditingController();
  TextEditingController controlContrasenaRepeat = TextEditingController();

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
              margin: const EdgeInsets.only(top: 150),
              child: Column(
                children: [
                  _productImage(entitiesProvider.productSelected.imagen_url!),
                  // _txtDatos('Nombre', Icons.person_sharp, 50,
                  //     TextInputType.name, controlNombre),
                  // _txtDatos('Apellido', Icons.person_sharp, 50,
                  //     TextInputType.name, controlApellido),
                  // _txtDatos(
                  //     'DNI',
                  //     Icons.account_box_outlined,
                  //     8,
                  //     const TextInputType.numberWithOptions(
                  //         signed: true, decimal: true),
                  //     controlDNI),
                  // _txtDatos(
                  //     'Telefono',
                  //     Icons.phone,
                  //     10,
                  //     const TextInputType.numberWithOptions(
                  //         signed: false, decimal: false),
                  //     controlTelefono),
                  // _txtDatos('Correo Electronico', Icons.email, 50,
                  //     TextInputType.emailAddress, controlEmail),
                  // _fecha(),
                  // _txtDatosPassword('Contraseña', Icons.password, 15,
                  //     TextInputType.visiblePassword, controlContrasena),
                  // // _txtDatosPassword(
                  // //     'Confirmar Contraseña',
                  // //     Icons.password,
                  // //     15,
                  // //     TextInputType.visiblePassword,
                  // //     controlContrasenaRepeat),
                  // _buttomRegistrar(entitiesProvider, appStateProvider),
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget _productImage(String imagen_url) {
    return Container(
      height: 170,
      width: 250,
      decoration: BoxDecoration(
        color: MyColors.secondaryColorOpacity,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Image.network(imagen_url),
    );
  }

  Widget _txtDatos(String label, IconData icon, int maxLength,
      TextInputType type, TextEditingController controller) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: MyColors.secondaryColorOpacity,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        style: const TextStyle(fontSize: 20),
        controller: controller,
        maxLength: maxLength,
        keyboardType: type,
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
}
