import 'package:another_flushbar/flushbar.dart';
import 'package:client_flutter_crud_node/src/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../provider/employee_provider.dart';
import '../utils/my_colors.dart';
import '../widgets/flush_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool obscureText = false;
  TextEditingController controlUser = TextEditingController();
  TextEditingController controlContrasenia = TextEditingController();

  @override
  void initState() {
    super.initState();
    //para tener el context despues de construida la app??
    SchedulerBinding.instance?.addPersistentFrameCallback((timeStamp) {
      // _con.init(context);
    });
    initializationANDRemoveSplashScreen();
  }

  void initializationANDRemoveSplashScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    var userLogin = Provider.of<UserProvider>(context);
    final employeeProviderMain = Provider.of<EmployeeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              top: -80,
              left: -100,
              child: _circularTitleLogin(),
            ),
            Positioned(
              child: Container(
                margin: const EdgeInsets.only(top: 65, left: 20),
                child: const Text(
                  "LOGIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'NimbusSans'),
                ),
              ),
            ),
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
            ),
          ],
        ),
      ),
    );
  }

  Widget _buttomAcceder(
      UserProvider userLogin, EmployeeProvider employeeProviderMain) {
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
          String controlUserText = controlUser.text.trim();
          String controlContraseniaText = controlContrasenia.text.trim();
          if (controlUserText.isNotEmpty && controlContraseniaText.isNotEmpty) {
            var rpta =
                userLogin.accessLogin(controlUserText, controlContraseniaText);

            final FocusScopeNode focus = FocusScope.of(context);
            if (!focus.hasPrimaryFocus && focus.hasFocus) {
              //SI EL TECLADO ESTA ACTIVO LO QUITAMOS
              FocusManager.instance.primaryFocus!.unfocus();
            }

            ///
            rpta.then((value) async {
              switch (value[0]) {
                case 1:
                  FlushBar()
                      .snackBarV2(value[1].toString(), Colors.green, context);
                  employeeProviderMain.getAllEmployee();
                  employeeProviderMain.getAllEmployeeTypes();
                  await Future.delayed(const Duration(seconds: 2));
                  Navigator.pushNamed(context, "home");
                  break;
                case 2:
                  FlushBar()
                      .snackBarV2(value[1].toString(), Colors.red, context);
                  break;
                case 3:
                  FlushBar()
                      .snackBarV2(value[1].toString(), Colors.red, context);
                  break;
                default:
              }
            });
          } else {
            FlushBar().snackBarV2(
                "Usuario y/o contraseña vacias", Colors.red, context);
          }
        },
        child: const Text(
          "ACCEDER",
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
          child: Text(
            "¿No tienes cuenta?",
            style: TextStyle(color: MyColors.primaryColor),
          ),
          margin: const EdgeInsets.only(right: 15),
        ),
        GestureDetector(
          child: Container(
            decoration: BoxDecoration(
                color: MyColors.secondaryColorOpacity,
                borderRadius: BorderRadius.circular(10)),
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            child: Text(
              "Registrate",
              style: TextStyle(
                  color: MyColors.primaryColor, fontWeight: FontWeight.bold),
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
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: MyColors.secondaryColorOpacity,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: controlContrasenia,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: "Contraseña",
          hintStyle: TextStyle(
            color: MyColors.primaryColor,
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
        validator: (value) {
          return value!.isEmpty ? 'Email cannot be blank' : null;
        },
      ),
    );
  }

  Container _txtCorreo() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: MyColors.secondaryColorOpacity,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        controller: controlUser,
        decoration: InputDecoration(
          hintText: "Correo electronico",
          hintStyle: TextStyle(
            color: MyColors.primaryColor,
          ),
          prefixIcon: Icon(
            Icons.alternate_email_outlined,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }

  Center _lottieDeliverMan() {
    return Center(
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
        color: MyColors.primaryColor,
        borderRadius: BorderRadius.circular(100),
      ),
    );
  }

  Container _tagLoaSi() {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.all(60),
      decoration: BoxDecoration(
        color: MyColors.secondaryColorOpacity,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Text(
        "LOAsi",
        style: TextStyle(
            color: Colors.black, fontSize: 40, fontWeight: FontWeight.bold),
      ),
    );
  }
}
