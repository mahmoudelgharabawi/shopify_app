import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopify_app/pages/cart.page.dart';
import 'package:shopify_app/providers/cart.provider.dart';

class CartBadgeWidget extends StatelessWidget {
  const CartBadgeWidget({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => CartPage()));
          },
          icon: const Icon(
            Icons.shopping_cart,
            color: Color(0xff727c8e),
            size: 20,
          ),
        ),
        Positioned(
            bottom: 6,
            child: StreamBuilder(
                stream: Provider.of<CartProvider>(context).cartStream,
                builder: (ctx, aSnapShot) {
                  if (aSnapShot.hasData) {
                    int quantity = 0;

                    for (Map<String, dynamic> item
                        in aSnapShot.data?.data()?['items']) {
                      quantity += (item['quantity'] as int);
                    }

                    return Badge(
                      smallSize: 15,
                      backgroundColor: const Color(0xffff6969),
                      label: Text(
                        '$quantity',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 10),
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                })),
      ],
    );
  }
}
