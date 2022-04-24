import 'package:flutter/material.dart';

class CardModalProduct extends StatefulWidget {
  const CardModalProduct({Key? key}) : super(key: key);

  @override
  State<CardModalProduct> createState() => _CardModalProductState();
}

class _CardModalProductState extends State<CardModalProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.transparent,
      child: Column(
        children: [
          Flexible(
              child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 30),
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 100,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [Text("Modal de seleccion de producto")],
                      )
                    ],
                  )))
        ],
      ),
    );
  }
}
