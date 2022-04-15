import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoAlertDialogCustom {
  CupertinoAlertDialogCustom();

  Future<dynamic> showCupertinoAlertDialog({
    required String title,
    required String msg,
    Function()? onPressedPositive,
    Function()? onPressedNegative,
    required BuildContext context,
  }) {
    return showDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
              insetAnimationCurve: Curves.bounceIn,
              title: Text(title),
              content: Text(msg),
              actions: [
                TextButton(
                  // onPressed: () {
                  //   Navigator.pushNamed(context, "login");
                  // },
                  onPressed: onPressedPositive ??
                      () {
                        Navigator.pushNamed(context, "login");
                      },
                  child: const Text(
                    "Aceptar",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                TextButton(
                  onPressed: onPressedNegative,
                  // onPressed: () {
                  //   Navigator.pop(context);
                  // },
                  child: const Text(
                    "Cancelar",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ));
  }
}
