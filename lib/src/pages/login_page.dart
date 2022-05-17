import 'package:client_flutter_crud_node/src/provider/entities_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../provider/app_state_provider.dart';
import '../utils/my_colors.dart';
import '../widgets/flush_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = true;
  TextEditingController controlUser = TextEditingController();
  TextEditingController controlContrasenia = TextEditingController();

  @override
  void initState() {
    super.initState();
    initializationANDRemoveSplashScreen();
    initSharedPreferences();
  }

  void initializationANDRemoveSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  void initSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    String? user = prefs.getString('user');
    String? contra = prefs.getString('contrasenia');

    controlUser.text = user ?? '';
    controlContrasenia.text = contra ?? '';
  }

  @override
  Widget build(BuildContext context) {
    var userLogin = Provider.of<EntitiesProvider>(context);
    final employeeProviderMain = Provider.of<AppStateProvider>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        physics: const BouncingScrollPhysics(),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circularTitleLogin(),
            ),
            const Positioned(
              top: 60,
              left: 20,
              child: Text(
                "LOGIN",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'NimbusSans'),
              ),
            ),
            // Container(
            //   color: Colors.black,
            // child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _tagLoaSi(),
                _lottieDeliverMan(),
                _txtCorreo(),
                _txtContrasena(),
                _buttomAcceder(userLogin, employeeProviderMain),
                _txtDontHaveAccount(),
              ],
              // ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttomAcceder(
      EntitiesProvider entitiesProvider, AppStateProvider appStateProvider) {
    print("EJECUCIONNN");
    bool proceso_login = true;
    //ESTA CONSULTANDO AL SERVIDOR
    if (entitiesProvider.isLoading) {
      setState(() {
        proceso_login = false; //DESACTIVAMOS EL PROCESO LOGIN
      });
    }
    // if (entitiesProvider.userAcceso != null) {
    //   setState(() {
    //     proceso_login = false; //DESACTIVAMOS POR QUE TIENE USER
    //   });
    // }

    print("PROCESO: $proceso_login");

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          primary: MyColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        onPressed: () async {
          if (proceso_login && entitiesProvider.userAcceso == null) {
            print("LOGIN : $proceso_login");

            String controlUserText = controlUser.text.trim();
            String controlContraseniaText = controlContrasenia.text.trim();
            if (controlUserText.isNotEmpty &&
                controlContraseniaText.isNotEmpty) {
              var rpta = entitiesProvider.accessLogin(
                  controlUserText, controlContraseniaText);

              final FocusScopeNode focus = FocusScope.of(context);
              if (!focus.hasPrimaryFocus && focus.hasFocus) {
                //SI EL TECLADO ESTA ACTIVO LO QUITAMOS
                FocusManager.instance.primaryFocus!.unfocus();
              }

              rpta.then((value) async {
                switch (value[0]) {
                  case 1: //ACCESOS CONCEDIDOS
                    if (mounted) {
                      FlushBar().snackBarV2(
                          value[1].toString(), Colors.green, context);
                    }

                    final prefs = await SharedPreferences.getInstance();

                    await prefs.setString('user', controlUserText);
                    await prefs.setString(
                        'contrasenia', controlContraseniaText);

                    entitiesProvider.getAllEmployee();
                    entitiesProvider.getAllProducts("", 1);
                    appStateProvider.getAllEmployeeTypes();
                    appStateProvider.getAllCategories();
                    await Future.delayed(const Duration(milliseconds: 2000));
                    Navigator.pushNamed(context, "home");
                    break;
                  case 2: //ACCESOS DENEGADOS
                    if (mounted) {
                      FlushBar()
                          .snackBarV2(value[1].toString(), Colors.red, context);
                    }
                    break;
                  case 3: //NO TUVO INFO DEL LOGIN
                    proceso_login = false;
                    if (mounted) {
                      FlushBar()
                          .snackBarV2(value[1].toString(), Colors.red, context);
                    }
                    break;
                  default:
                }
              });
            } else {
              if (mounted) {
                FlushBar().snackBarV2(
                    "Usuario y/o contraseña vacias", Colors.red, context);
              }
            }
          } else if (entitiesProvider.userAcceso == null) {
            print("CARGANDO...");
            if (mounted) {
              FlushBar().snackBarV2("Cargando", Colors.purple[700]!, context);
            }
          }
        },
        child: const Text(
          "ACCEDER",
          // entitiesProvider.isLoading ? "CARGANDO ..." : "ACCEDER",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Row _txtDontHaveAccount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          child: const Text(
            "¿No tienes cuenta?",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          margin: const EdgeInsets.only(right: 15),
        ),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: const Text(
              "Registrate",
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
          onTap: () {
            // _con.goToRegisterPage();
            // Fluttertoast.showToast(msg: "Registrando");
            Navigator.pushNamed(context, "register");
          },
        ),
      ],
    );
  }

  Container _txtContrasena() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        style: const TextStyle(fontSize: 20),
        controller: controlContrasenia,
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Contraseña",
          hintStyle: TextStyle(
            color: MyColors.primaryColor,
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.password_outlined,
            color: MyColors.primaryColor,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
            icon: obscureText
                ? Icon(
                    Icons.visibility_rounded,
                    color: MyColors.primaryColor,
                  )
                : const Icon(Icons.visibility_off_rounded),
          ),
        ),
        textInputAction: TextInputAction.done,
        validator: (value) {
          return value!.isEmpty ? 'Email cannot be blank' : null;
        },
      ),
    );
  }

  Container _txtCorreo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      // padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        style: const TextStyle(fontSize: 20),
        controller: controlUser,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Correo electronico",
          hintStyle: TextStyle(
            color: MyColors.primaryColor,
            fontSize: 15,
          ),
          prefixIcon: Icon(
            Icons.alternate_email_outlined,
            color: MyColors.primaryColor,
          ),
        ),
        textInputAction: TextInputAction.next,
      ),
    );
  }

  Widget _lottieDeliverMan() {
    return Container(
      // padding: const EdgeInsets.all(35),
      margin: const EdgeInsets.only(top: 70, bottom: 30),
      child: Lottie.asset(
        'assets/lotties/phoneAppDelivery.json',
        fit: BoxFit.fill,
        // height: 220,
        width: double.infinity,
        alignment: Alignment.bottomCenter,
        repeat: true,
        reverse: true,
        animate: true,
      ),
    );
  }

  Widget _circularTitleLogin() {
    return Container(
      width: 240,
      height: 230,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Container _tagLoaSi() {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(top: 40, right: 15),
      decoration: BoxDecoration(
        color: MyColors.primaryColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Text(
        "LOAsi",
        style: TextStyle(
            color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
