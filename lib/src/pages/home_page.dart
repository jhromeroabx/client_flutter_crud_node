import 'package:client_flutter_crud_node/src/pages/Navigator/almacen.dart';
import 'package:client_flutter_crud_node/src/pages/Navigator/inicio_page.dart';
import 'package:client_flutter_crud_node/src/pages/Navigator/manage_employee.dart';
import 'package:client_flutter_crud_node/src/pages/test/bar_code.dart';
import 'package:client_flutter_crud_node/src/widgets/CupertinoDialogCustom.dart';
import 'package:flutter/material.dart';

import 'Navigator/ingreso_compra.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 1;
  final screens = [
    const InicioApp(),
    const AlmacenGestion(),
    const ManageEmployeePage(title: "Gestion de empleados"),
    const IngresoAlmacen(),
    const BarCodePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text("Sistema de Almacen"),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundColor: Colors.red[100],
              child: IconButton(
                tooltip: "Cerrar sesion",
                icon: Icon(
                  Icons.logout,
                  color: Colors.red[300],
                  size: 30,
                ),
                onPressed: () {
                  CupertinoAlertDialogCustom().showCupertinoAlertDialog(
                    title: "Cerrar Sesion",
                    msg: "¿Estas seguro de Cerrar Sesion?",
                    onPressedPositive: () {
                      Navigator.pushNamed(context, "login");
                    },
                    onPressedNegative: () {
                      Navigator.pop(context);
                    },
                    context: context,
                  );
                },
              ),
            ),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: screens[index],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 5,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_filled,
              color: index == 0 ? Colors.orange : Colors.black,
            ),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_box,
              color: index == 1 ? Colors.green : Colors.black,
            ),
            label: 'Inventario',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.precision_manufacturing_outlined,
              color: index == 2 ? Colors.green : Colors.black,
            ),
            label: 'Gestion Almacen',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.file_upload,
              color: index == 3 ? Colors.blue : Colors.black,
            ),
            label: 'Ingreso',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.download,
              color: index == 4 ? Colors.orange : Colors.black,
            ),
            label: 'Retiro',
          ),
        ],
        iconSize: 25,
        backgroundColor: Colors.lightBlueAccent[500],
        currentIndex: index,
        unselectedItemColor: Colors.black,
        selectedFontSize: 15,
        selectedItemColor: Colors.blue,
        onTap: (index) => setState(() => this.index = index),
      ),
    );
  }
}
