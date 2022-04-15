import 'package:flutter/material.dart';

class CardCustomType2 extends StatelessWidget {
  final String imageURL;
  final String? name;

  const CardCustomType2({
    Key? key,
    required this.imageURL,
    this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      //no permite que los hijos se salgan del borde del padre
      clipBehavior: Clip.antiAlias,
      //agregamos bordes redondeados
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      elevation: 30,
      shadowColor: Colors.blue,
      child: Column(
        children: [
          Image.network(
            imageURL,
            // placeholder: const AssetImage('assets/carga.gif'),
            // image: NetworkImage(imageURL),
            //limitamos el tamaño del widget para que no crezca mas de los limites
            width: double.infinity,
            height: 100,
            //imagen cubren el tamaño del widget
            fit: BoxFit.cover,
          ),
          //si la variable es null no construye el texto
          if (name != null)
            Container(
              alignment: AlignmentDirectional.centerEnd,
              padding: const EdgeInsets.only(right: 20, top: 10, bottom: 10),
              // child: Text(name ?? "Un hermoso paisaje. no titulo"),
              child: Text(name!),
            )
        ],
      ),
    );
  }
}
