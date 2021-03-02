import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:whatsapp/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  ProductCard({@required this.product});

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(right: 5, left: 5, bottom: 10),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 200,
            width: screenSize.width,
            child: CachedNetworkImage(
                imageUrl: product.image,
                fit: BoxFit.cover,
                placeholder: (BuildContext context, String text) {
                  return Image(
                    image: AssetImage('assets/images/placeholder-image.png'),
                    fit: BoxFit.cover,
                  );
                }),
          ),
          Container(
            alignment: Alignment.centerRight,
            height: 60,
            decoration: BoxDecoration(color: Colors.black45),
            child: Padding(
              padding: const EdgeInsets.only(right: 15,left: 5),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    product.title,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  RichText(
                    maxLines: 1,
                    text: TextSpan(
                      text: product.body,
                      style: TextStyle(
                          fontSize: 13, fontFamily: 'Vazir', color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
