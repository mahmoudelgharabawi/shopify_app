import 'package:flutter/material.dart';
import 'package:shopify_app/models/product.model.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.product});
  final Product product;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
                color: Color(0xffe7eaf0), spreadRadius: 5, blurRadius: 10),
          ]),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              product.image ?? '',
              width: 85,
              height: 79,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                product.name ?? 'No Name',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff515c6f),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '\$${product.price}',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff515c6f),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
