import 'package:client_flutter_crud_node/src/pages/Navigator/almacen.dart';
import 'package:client_flutter_crud_node/src/pages/Navigator/inicio_page.dart';
import 'package:client_flutter_crud_node/src/pages/Navigator/manage_employee.dart';
import 'package:client_flutter_crud_node/src/pages/test/bar_code.dart';
import 'package:client_flutter_crud_node/src/widgets/CupertinoDialogCustom.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../provider/products_in_out_provider.dart';
import 'Navigator/ingreso_compra.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index_page = 1;
  final screens = [
    const InicioApp(),
    const AlmacenGestion(),
    const ManageEmployeePage(title: "Gestion de empleados"),
    const IngresoAlmacen(),
    const BarCodePage(),
  ];

  @override
  Widget build(BuildContext context) {
    var productSelectedProvider = Provider.of<ProductsInOutProvider>(context);

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
                      productSelectedProvider.cleanShoppingCart();
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
      body: screens[index_page],
      bottomNavigationBar: GNav(
        rippleColor: Colors.grey[200]!,
        hoverColor: Colors.grey[200]!,
        // haptic: true,
        tabBorderRadius: 15,
        tabActiveBorder:
            Border.all(color: Colors.black, width: 1), // tab button border
        tabBorder:
            Border.all(color: Colors.grey, width: 1), // tab button border
        tabShadow: [
          BoxShadow(color: Colors.blue.withOpacity(0.1), blurRadius: 8)
        ], // tab button shadow
        curve: Curves.easeOutExpo, // tab animation curves
        duration: const Duration(milliseconds: 200), // tab animation duration
        gap: 2, // the tab button gap between icon and text
        color: Colors.grey[100], // unselected icon color
        activeColor: Colors.blue[900], // selected icon and text color
        iconSize: 40, // tab button icon size
        textSize: 100,
        // style: GnavStyle.google,
        tabBackgroundColor:
            Colors.blue[100]!.withOpacity(0.1), // selected tab background color
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 12),
        tabs: [
          GButton(
            icon: Icons.home_filled,
            text: 'Dashboard',
            iconColor: index_page != 0 ? Colors.orange : Colors.black,
          ),
          GButton(
            icon: Icons.check_box,
            text: 'Inventario',
            iconColor: index_page != 1 ? Colors.green : Colors.black,
          ),
          GButton(
            icon: Icons.precision_manufacturing_outlined,
            text: 'Gestion Personal',
            iconColor: index_page != 2 ? Colors.grey[700] : Colors.black,
          ),
          GButton(
            icon: Icons.file_upload,
            text: 'Ingreso',
            iconColor: index_page != 3 ? Colors.blue : Colors.black,
          ),
          GButton(
            icon: Icons.download,
            text: 'Retiro',
            iconColor: index_page != 4 ? Colors.red : Colors.black,
          ),
        ],
        // selectedIndex: index_page,
        onTabChange: (index) {
          setState(() {
            index_page = index;
          });
        },
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   type: BottomNavigationBarType.fixed,
      //   elevation: 5,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home_filled,
      //         color: index == 0 ? Colors.orange : Colors.black,
      //       ),
      //       label: 'Dashboard',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.check_box,
      //         color: index == 1 ? Colors.green : Colors.black,
      //       ),
      //       label: 'Inventario',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.precision_manufacturing_outlined,
      //         color: index == 2 ? Colors.green : Colors.black,
      //       ),
      //       label: 'Gestion Almacen',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.file_upload,
      //         color: index == 3 ? Colors.blue : Colors.black,
      //       ),
      //       label: 'Ingreso',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.download,
      //         color: index == 4 ? Colors.orange : Colors.black,
      //       ),
      //       label: 'Retiro',
      //     ),
      //   ],
      //   iconSize: 25,
      //   backgroundColor: Colors.lightBlueAccent[500],
      //   currentIndex: index,
      //   unselectedItemColor: Colors.black,
      //   selectedFontSize: 15,
      //   selectedItemColor: Colors.blue,
      //   onTap: (index) => setState(() => this.index = index),
      // ),
    );
  }
}
