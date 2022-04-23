import 'package:flutter/material.dart';

import '../utils/my_colors.dart';

class ProductItems extends StatelessWidget {
  final String? imageURL;
  final String? name;
  final String? cantidad;
  final String? precio;
  final Color? color;

  const ProductItems({
    Key? key,
    this.imageURL,
    this.name,
    this.precio,
    this.cantidad,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color ?? MyColors.secondaryColorOpacity,
        borderRadius: BorderRadius.circular(25),
      ),
      width: 170,
      height: 250,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageURL != null)
            Container(
              padding: const EdgeInsets.all(10),
              child: Image.network(
                imageURL!,
                // placeholder: const AssetImage('assets/carga.gif'),
                // image: NetworkImage(imageURL),
                //limitamos el tamaño del widget para que no crezca mas de los limites
                width: 120,
                height: 125,
                //imagen cubren el tamaño del widget
                fit: BoxFit.cover,
              ),
            ),
          if (name != null)
            Container(
              // alignment: AlignmentDirectional.topEnd,
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 10),
              // child: Text(name ?? "Un hermoso paisaje. no titulo"),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    name!,
                    style: const TextStyle(fontSize: 20),
                    overflow: TextOverflow.ellipsis,
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
