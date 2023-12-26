import 'package:client_flutter_crud_node/src/pages/Navigator/almacen.dart';
import 'package:client_flutter_crud_node/src/pages/Navigator/inicio_page.dart';
import 'package:client_flutter_crud_node/src/pages/Navigator/manage_employee.dart';
import 'package:client_flutter_crud_node/src/provider/employee_provider.dart';
import 'package:client_flutter_crud_node/src/provider/user_provider.dart';
import 'package:client_flutter_crud_node/src/widgets/CupertinoDialogCustom.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import '../../test/bar_code.dart';
import '../../test/incrementador.dart';
import '../provider/products_in_out_provider.dart';
import 'Navigator/ingreso_compra.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index_page = 0;
  final screens = [
    const IncrementadorPage(),
    const AlmacenGestion(),
    const ManageEmployeePage(),
    const IngresoAlmacen(),
    const BarCodePage(),
  ];

  final screensTitle = [
    'DashBoard',
    'Almacen',
    'Gestion',
    'Ingreso Productos',
    'Salida Productos',
  ];

  @override
  Widget build(BuildContext context) {
    var productSelectedProvider = Provider.of<ProductsInOutProvider>(context);
    var userProvider = Provider.of<UserProvider>(context);

    Future<bool> showExitPopup() async {
      return await CupertinoAlertDialogCustom().showCupertinoAlertDialog(
              title: "Cerrar Sesion",
              msg: "¿Estas seguro de Cerrar Sesion?",
              context: context,
              onPressedNegative: () {
                Navigator.of(context).pop(false);
              },
              onPressedPositive: () {
                productSelectedProvider.cleanShoppingCart();
                userProvider.userAcceso = null;
                Navigator.pushReplacementNamed(context, "login");
              }) ??
          false;
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("${screensTitle[index_page]} - LOAsi"),
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
                        userProvider.userAcceso = null;
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
        bottomNavigationBar: CustomLineIndicatorBottomNavbar(
          selectedColor: Colors.blueAccent,
          unSelectedColor: Colors.black54,
          backgroundColor: Colors.white,
          currentIndex: index_page,
          unselectedIconSize: 20,
          selectedIconSize: 25,
          onTap: (index) {
            setState(() {
              index_page = index;
            });
          },
          enableLineIndicator: true,
          lineIndicatorWidth: 3,
          indicatorType: IndicatorType.Top,
          // gradient: LinearGradient(
          //   colors: [Colors.grey, Colors.grey[300]!],
          // ),
          customBottomBarItems: [
            CustomBottomBarItems(
              icon: Icons.home,
              label: 'Dashboard',
            ),
            CustomBottomBarItems(
              icon: Icons.check_box,
              label: 'Almacen',
            ),
            CustomBottomBarItems(
              icon: Icons.precision_manufacturing_outlined,
              label: 'Gestión',
            ),
            CustomBottomBarItems(
              icon: Icons.file_upload,
              label: 'Ingreso',
            ),
            CustomBottomBarItems(
              icon: Icons.download,
              label: 'Salida',
            ),
          ],
        ),
      ),
    );
  }
}
