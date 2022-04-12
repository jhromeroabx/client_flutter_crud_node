import 'package:client_flutter_crud_node/src/pages/edit_or_create_page.dart';
import 'package:client_flutter_crud_node/src/pages/home_page.dart';
import 'package:client_flutter_crud_node/src/pages/test/bar_code.dart';
import 'package:client_flutter_crud_node/src/pages/test/incrementador.dart';
import 'package:client_flutter_crud_node/src/service/employee_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

import 'src/pages/test/refresh_basic.dart';
import 'src/pages/test/refresh_future_builder.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => EmployeeProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Gestion Registros',
        initialRoute: 'home',
        routes: {
          'incrementador': (_) =>
              const IncrementadorPage(title: 'Flutter Demo Home Page'),
          'home': (_) => const HomePage(title: 'Gestion de Usuarios'),
          'barcode': (_) => const BarCodePage(),
          'edit/create': (_) => const EditOrCreatePage(),
          'refreshFutBuild': (_) => const RefreshFutBuild(),
          'refreshBasic': (_) => const RefreshBasic(),
        },
      ),
    );
  }
}
