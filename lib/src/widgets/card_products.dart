// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../utils/my_colors.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:text_marquee/text_marquee.dart';
class ProductItems extends StatelessWidget {
  final String? imageURL;
  final String? name;
  final String? cantidad;
  final String? precio;
  final Color? color;
  final double? ancho;
  final double? alto;
  //
  final bool? counterShow;
  final int? counterCantidad;

  const ProductItems({
    Key? key,
    this.imageURL,
    this.name,
    this.precio,
    this.cantidad,
    this.color,
    this.ancho,
    this.alto,
    this.counterShow = false,
    this.counterCantidad = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 170,
          height: 212,
          decoration: BoxDecoration(
            color: color ?? MyColors.secondaryColorOpacity,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                Container(
                  width: 120,
                  height: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: imageURL != null && imageURL!.isNotEmpty
                        ? FadeInImage.assetNetwork(
                            fadeInDuration: const Duration(milliseconds: 500),
                            fadeInCurve: Curves.easeInExpo,
                            fadeOutCurve: Curves.easeOutExpo,
                            placeholder: 'assets/images/gallery.jpg',
                            image: imageURL!,
                            imageErrorBuilder: (context, error, stackTrace) {
                              return Image.asset(
                                "assets/images/gallery.jpg",
                                height: 100,
                                width: 100,
                              );
                            },
                            fit: BoxFit.cover,
                          )
                        : Image.asset(
                            'assets/images/gallery.jpg',
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                const SizedBox(height: 10),
                if (name != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                    TextMarquee(
                      name!,
                      spaceSize: 72,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w600,
                        fontSize: 17,
                      ),
                    ),
                      const SizedBox(height: 5),
                      if (precio != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.attach_money,
                              color: Colors.green,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              precio!,
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.green[700],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      if (cantidad != null)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.shopping_cart,
                              color: Colors.blue,
                              size: 20,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              cantidad!,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
