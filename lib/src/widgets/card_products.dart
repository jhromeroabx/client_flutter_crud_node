import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class ProductItems extends StatelessWidget {
  final String imageURL;
  final String? name;
  final String? cantidad;
  final String? precio;

  const ProductItems({
    Key? key,
    required this.imageURL,
    this.name,
    this.precio,
    this.cantidad,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: MyColors.secondaryColorOpacity,
        borderRadius: BorderRadius.circular(25),
      ),
      width: 170,
      height: 230,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Image.network(
              imageURL,
              // placeholder: const AssetImage('assets/carga.gif'),
              // image: NetworkImage(imageURL),
              //limitamos el tamaño del widget para que no crezca mas de los limites
              width: 120,
              height: 125,
              //imagen cubren el tamaño del widget
              fit: BoxFit.cover,
            ),
          ),
          //si la variable es null no construye el texto
          if (name != null)
            Container(
              alignment: AlignmentDirectional.bottomStart,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              // child: Text(name ?? "Un hermoso paisaje. no titulo"),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name!,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Precio:"),
                      Text(precio!),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Cantidad:"),
                      Text(cantidad!),
                    ],
                  ),
                ],
              ),
            )
        ],
      ),
    );
  }
}
