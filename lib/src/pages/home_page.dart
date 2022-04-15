import 'package:client_flutter_crud_node/src/pages/Navigator/almacen.dart';
import 'package:client_flutter_crud_node/src/pages/Navigator/inicio_page.dart';
import 'package:client_flutter_crud_node/src/pages/Navigator/inventario.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  final screens = [
    const InicioApp(),
    const Inventario(),
    const AlmacenGestion(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sistema de Almacene"),
        actions: [],
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
            label: 'Inicio',
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
              color: index == 2 ? Colors.blue : Colors.black,
            ),
            label: 'Gestion Almacen',
          ),
        ],
        iconSize: 30,
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
