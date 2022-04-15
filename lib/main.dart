import 'package:client_flutter_crud_node/src/pages/Navigator/edit_or_create_employee.dart';
import 'package:client_flutter_crud_node/src/pages/Navigator/manage_employee.dart';
import 'package:client_flutter_crud_node/src/pages/login_page.dart';
import 'package:client_flutter_crud_node/src/pages/register_page.dart';
import 'package:client_flutter_crud_node/src/pages/test/bar_code.dart';
import 'package:client_flutter_crud_node/src/pages/test/incrementador.dart';
import 'package:client_flutter_crud_node/src/provider/app_state_provider.dart';
import 'package:client_flutter_crud_node/src/provider/entities_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'src/pages/home_page.dart';
import 'src/pages/test/refresh_basic.dart';
import 'src/pages/test/refresh_future_builder.dart';
import 'src/utils/my_colors.dart';

void main() {
  //for splash screen time delay
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  //for splash screen time delay

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AppStateProvider()),
        ChangeNotifierProvider(create: (context) => EntitiesProvider()),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: MyColors.primaryColor, fontFamily: 'Roboto'),
        debugShowCheckedModeBanner: false,
        // title: 'Gestion Productos',
        initialRoute: 'login',
        routes: {
          'incrementador': (_) =>
              const IncrementadorPage(title: 'Flutter Demo Home Page'),
          'home': (_) => const HomePage(),
          'manageEmployee': (_) =>
              const ManageEmployeePage(title: 'Gestion de Empleados'),
          'login': (_) => const LoginPage(),
          'barcode': (_) => const BarCodePage(),
          'edit/create': (_) => const EditOrCreateEmployeePage(),
          'refreshFutBuild': (_) => const RefreshFutBuild(),
          'refreshBasic': (_) => const RefreshBasic(),
          'register': (_) => const RegisterPage(),
        },
      ),
    );
  }
}
