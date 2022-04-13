import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushBar {
  FlushBar();

  Future<dynamic> snackBarV2(
      String msg, Color colorState, BuildContext context) {
    return Flushbar(
      duration: const Duration(milliseconds: 3000),
      message: msg,
      messageSize: 25,
      backgroundGradient: LinearGradient(colors: [
        Colors.black,
        colorState,
      ]),
      // mainButton: IconButton(
      //   icon: const Icon(Icons.copy, size: 30),
      //   onPressed: () {
      //     _copyToClipboard(scanData.code!);
      //   },
      // ),
    ).show(context);
  }
}
