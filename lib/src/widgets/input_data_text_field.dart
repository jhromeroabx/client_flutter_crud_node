import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class TextDataBasic extends StatelessWidget {
  const TextDataBasic({
    Key? key,
    required this.label,
    required this.icon,
    required this.maxLength,
    required this.type,
    required this.controller,
  }) : super(key: key);

  final String? label;
  final IconData? icon;
  final int? maxLength;
  final TextInputType? type;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: MyColors.secondaryColorOpacity,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextFormField(
        style: const TextStyle(fontSize: 20),
        controller: controller,
        maxLength: maxLength,
        keyboardType: type,
        decoration: InputDecoration(
          border: InputBorder.none,
          // hintText: hintText,
          hintStyle: TextStyle(
            color: MyColors.primaryColor,
          ),
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: MyColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
